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

	local result = WorldDBQuery("SELECT entry FROM arcmercs.mercenaries WHERE ownerGuid = '"..data.."' AND groupId = "..group.."")

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

		WorldDBQuery("DELETE FROM arcmercs.mercenaries WHERE ownerGuid = '"..tostring(data).."'")

		plr:SendBroadcastMessage( "Your mercenary info has been reseted." )

		plr:GossipComplete()

	end

	if( intid == 1 ) then

		if( level >= 10 ) then

			if getMercCount( plr, intid ) < 3 then

				if( coins > 10 ) then

					local e = soldierId[ plr:GetTeam() + 1 ]

					local angle = math.random( 0, 5 )
					
					local merc = plr:CreateGuardian( e, 0, angle, level )
					
					WorldDBQuery("INSERT INTO arcmercs.mercenaries (ownerGuid, groupId, entry, display, angle, mercGuid, ownerName, type) VALUES ('"..tostring(data).."', "..intid..", "..e..", "..merc:GetDisplay()..", "..angle..", '"..tostring(merc:GetGUID()).."', '"..plr:GetName().."', 'Soldier' )")
					
					local guid = tostring(merc)
					
					if not ARCMERCS[guid] then
					
						ARCMERCS[guid] = {}
						
					end
					
					plr:SendBroadcastMessage( "You have hired an "..merc:GetName().."." )

					plr:GossipComplete()

				else

					-- player hasn money to hire

					unit:GossipCreateMenu( 68001, plr, 0 )

					unit:GossipSendMenu( plr )

				end

			else

				-- player hasn room for more soldiers

				unit:GossipCreateMenu( 68002, plr, 0 )

				unit:GossipSendMenu( plr )

			end

		else

			-- player level is not enough

			unit:GossipCreateMenu( 68003, plr, 0 )

			unit:GossipSendMenu( plr )

		end

	end

	if( intid == 2 ) then

		plr:SendBroadcastMessage( "You have hired an healer" )

	end

	if( intid == 3 ) then

		plr:SendBroadcastMessage( "You have hired an officer" )

	end

	if( intid == 4 ) then

		-- TODO

	end

	--plr:GossipComplete()

end

RegisterUnitGossipEvent( 43283, 1, ARCMERCS.MasterOnHello );
RegisterUnitGossipEvent( 43283, 2, ARCMERCS.MasterOnSelection );