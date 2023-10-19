local soldierId = { 43284, 43285 }

ARCMERCS = {}

--- getMercCount()
---   Get the ammount of mercenaries than the player has.
---
--- Parameter(s)
---   plr
---   group
---
--- Return value
---   Returns the number of mercenaries.
---
function getMercCount( plr, group )

	local data = tostring( plr:GetGUID() )

	local count = 0

	local result = WorldDBQuery(" SELECT entry FROM arcmercs.mercenaries WHERE ownerGuid = '"..data.."' and groupId = "..group.."  ")

	if result then

		local rowcount = result:GetRowCount()

		repeat
			rowcount = rowcount - 1
			local entry = result:GetColumn( 0 ):GetUShort()

			if entry ~= 0 then

				count = count + 1

			end

		result:NextRow()

		until rowcount == 0

	end

	return count

end

function ARCMERCS.MasterOnHello( unit, event, plr )

	unit:GossipCreateMenu( 68000, plr, 0 )

	unit:GossipMenuAddItem( 0, "Reset.", 0, 0 )

	unit:GossipMenuAddItem( 6, "I want a Soldier.", 1, 0 )

	unit:GossipMenuAddItem( 6, "I need a Healer.", 2, 0 )
	
	unit:GossipMenuAddItem( 6, "Give me an Officer.", 3, 0 )
	
	unit:GossipSendMenu( plr )

end

function ARCMERCS.MasterOnSelection( unit, event, plr, id, intid, code )

	local data = tostring( plr:GetGUID() )

	local level = plr:GetLevel()

	local coins = plr:GetCoinage()

	if( intid == 0 ) then

		WorldDBQuery(" DELETE FROM arcmercs.mercenaries WHERE ownerGuid = '"..tostring(data).."' ")

		--unit:SendChatMessage( 12, 0, "Your mercenary info has been reseted." )

		plr:SendBroadcastMessage( "Your mercenary info has been reseted." )

		plr:GossipComplete()

	end

	if( intid == 1 ) then

		if( level >= 10 ) then

			if getMercCount( plr, intid ) < 3 then

				if( coins > 10 ) then

					local e = soldierId[ plr:GetTeam() + 1 ]

					WorldDBQuery(" INSERT INTO arcmercs.mercenaries (ownerGuid, groupId, entry, ownerName, type) VALUES ('"..tostring(data).."', "..intid..", "..e..", '"..plr:GetName().."', 'Soldier' ) ")

					local merc = plr:CreateGuardian( e, 0, math.random( 1, 6 ), level )

					-- unit:SendChatMessage( 12, 0, "Take your Soldier." )
					
					plr:SendBroadcastMessage( "You have hired a Mercenary." );

					plr:GossipComplete()

				else

					--unit:SendChatMessage( 12, 0, "I apologize, "..plr:GetName().." but you do not have the amount of money I require." );

					unit:GossipCreateMenu( 68001, plr, 0 )

					unit:GossipSendMenu( plr )

				end

			else

				--unit:SendChatMessage( 12, 0, "Im sorry, "..plr:GetName().." but i cant spare more than three Soldiers for each hero." )

				unit:GossipCreateMenu( 68002, plr, 0 )

				unit:GossipSendMenu( plr )

			end

		else

			-- unit:SendChatMessage( 12, 0, "Hi there, "..plr:GetName().." im afraid than your level is not enough." )

			unit:GossipCreateMenu( 68003, plr, 0 )

			unit:GossipSendMenu( plr )

		end

	end

	if( intid == 2 ) then

		unit:SendChatMessage( 12, 0, "Take your Healer." )

	end

	if( intid == 3 ) then

		unit:SendChatMessage( 12, 0, "Take your Officer." )

	end

	if( intid == 4 ) then

		-- TODO

	end

	--plr:GossipComplete()

end

RegisterUnitGossipEvent( 43283, 1, ARCMERCS.MasterOnHello );
RegisterUnitGossipEvent( 43283, 2, ARCMERCS.MasterOnSelection );