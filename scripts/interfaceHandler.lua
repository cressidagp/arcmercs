-- local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;
-- local UNIT_FIELD_CREATEDBY  = 0x0006 + 0x000A;

ARCMERCS = {}

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
			
			unit:GossipMenuAddItem( 8, "Customize.", 8, 0 )

		else

			unit:GossipCreateMenu( 3, plr, 0 )

		end

	end

	unit:GossipSendMenu( plr )

end
	

function ARCMERCS.MercsOnSelection( unit, event, plr, id, intid, code )

	if intid == 0 then
	
		if getMercCount( plr, 0 ) < 3 then
			
			if( plr:GetCoinage() > 10 ) then
			
				unit:SendChatMessage( 12, 0, "Yes." )
			
			end
			
		end
	
	end
	
	if intid == 1 then
	
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
	
		showSpells( entry, fightStyle )
	
	end	

	if intid == 8 then
	
		showDisplayOptions( entry, faction )
	
	end	
	
	plr:GossipComplete()

end

-- Alliance
RegisterUnitGossipEvent( 43284, 1, ARCMERCS.MercsOnHello );
RegisterUnitGossipEvent( 43284, 2, ARCMERCS.MercsOnSelection );

-- Horde
RegisterUnitGossipEvent( 43285, 1, ARCMERCS.MercsOnHello );
RegisterUnitGossipEvent( 43285, 2, ARCMERCS.MercsOnSelection );