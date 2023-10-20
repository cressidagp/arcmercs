-- local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;

ARCMERCS = {}
DB = {}

--- getDisplayOptions
---   Gets from database all displayId options for a class of mercenary.
---
--- Parameter(s)
---   entry
---
--- Return value
---   None.
---
function getDisplayOptions( entry )
	
	DB["rowcount"] = 0

	local result = WorldDBQuery(" SELECT groupId, optionName, optionId, display FROM arcmercs.gossip_display WHERE entry = '"..entry.."' ")

	if result then

		local count = result:GetRowCount()

		DB["rowcount"] = count

		for i = 1, count do

			DB[ i ] = { result:GetColumn( 0 ):GetShort(), result:GetColumn( 1 ):GetString(), result:GetColumn( 2 ):GetShort(), result:GetColumn( 3 ):GetLong() }

			--print( DB[i][1], DB[i][2], DB[i][3] )

			result:NextRow()

		end 

	end

end

function ARCMERCS.MercsOnHello( unit, event, plr )

	local value = unit:GetUInt64Value( 0x0006 + 0x0008 )

	if value == nil then

		unit:GossipCreateMenu( 1, plr, 0 )

		unit:GossipMenuAddItem( 6, "I see. I accept your offer.", 0, 0 )

		unit:GossipMenuAddItem( 0, "I do not need you now, Mercenary.", 1, 0 )

	else

		local plrGuid = tostring(plr:GetGUID())

		local ownerGuid = tostring(value)

		if ownerGuid == plrGuid then

			unit:GossipCreateMenu( 2, plr, 0 )

			unit:GossipMenuAddItem( 4, "Use a more balance fight style.", 2, 0 )

			unit:GossipMenuAddItem( 4, "Focus more on defense right now.", 3, 0 )

			unit:GossipMenuAddItem( 4, "Go into aggressive fight style for now.", 4, 0 )

			unit:GossipMenuAddItem( 9, "Attack my target.", 5, 0 )

			unit:GossipMenuAddItem( 2, "Move to my target.", 6, 0 )

			unit:GossipMenuAddItem( 3, "Show me your abilities.", 7, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow front.", 8, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow LF.", 9, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow L.", 10, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow LB.", 11, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow back.", 12, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow RB.", 13, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow R.", 14, 0 )
			
			unit:GossipMenuAddItem( 2, "Follow RF.", 15, 0 )

			unit:GossipMenuAddItem( 8, "Customize.", 16, 0 )

		else

			unit:GossipCreateMenu( 3, plr, 0 )

		end

	end

	unit:GossipSendMenu( plr )

end

function ARCMERCS.MercsOnSelection( unit, event, plr, id, intid, code )

	if intid < 16 then

		if intid == 0 then

			if getMercCount( plr, 0 ) < 3 then

				if plr:GetCoinage() > 10 then

					unit:SendChatMessage( 12, 0, "Yes." )

				end

			end

		end

		if intid == 1 then

			unit:SendChatMessage( 12, 0, "Fuck you." )

		end

		if intid == 2 then

			unit:SendChatMessage( 12, 0, "Very well I shall fight in a mixed style." )

		end

		if intid == 3 then

			unit:SendChatMessage( 12, 0, "Well, Tank mode it is then." )

		end	

		if intid == 4 then

			unit:SendChatMessage( 12, 0, "Ok, I will be taking more damage, just so you know." )

		end	

		if intid == 5 then

			unit:SendChatMessage( 12, 0, "Charge!!!" )

		end

		if intid == 6 then

			unit:SendChatMessage( 12, 0, "As you wish." )

		end

		if intid == 7 then

			--showSpells( entry, fightStyle )

		end

		if intid == 8 then
		
			unit:SetUnitToFollow( plr, 2, 0 ) -- front (0)

		end

		if intid == 9 then
		
			unit:SetUnitToFollow( plr, 2, 1.04 ) -- left front (60)

		end
		
		if intid == 10 then
		
			unit:SetUnitToFollow( plr, 2, 1.57) -- Left (90)

		end
		
		if intid == 11 then
		
			unit:SetUnitToFollow( plr, 2, 2.09 ) -- left back (120)

		end
		
		if intid == 12 then
		
			unit:SetUnitToFollow( plr, 2, 3.14) -- Back (180)

		end
		
		if intid == 13 then
		
			unit:SetUnitToFollow( plr, 2, 4.18) -- Right back (240)

		end
		
		if intid == 14 then
		
			unit:SetUnitToFollow( plr, 2, 4.71) -- Right (270)

		end
		
		if intid == 15 then
		
			unit:SetUnitToFollow( plr, 2, 5.23) -- Right (300)

		end

		plr:GossipComplete()
	
	end

	if intid == 16 then

		getDisplayOptions( unit:GetEntry() )
		
		unit:GossipCreateMenu( 4, plr, 0 )

		for i = 1, DB["rowcount"] do

			unit:GossipMenuAddItem( 8, DB[i][2], DB[i][3], 0 )
			
			--print(DB[i][2], DB[i][3], DB[i][4])

		end

		unit:GossipSendMenu( plr )

	end
	
	if intid >= 17 then
	
		unit:SetModel( DB[intid-16][4] )
		
		plr:GossipComplete()

	end

	--plr:GossipComplete()

end

-- Alliance:
RegisterUnitGossipEvent( 43284, 1, ARCMERCS.MercsOnHello );
RegisterUnitGossipEvent( 43284, 2, ARCMERCS.MercsOnSelection );

-- Horde:
RegisterUnitGossipEvent( 43285, 1, ARCMERCS.MercsOnHello );
RegisterUnitGossipEvent( 43285, 2, ARCMERCS.MercsOnSelection );