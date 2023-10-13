local soldierId = { 43284, 43285 };

ARCMERCS = {}

function getMercCount( plr, group )
	
	local data = tostring( plr:GetGUID() )
	
	local count = 0
	
	local result = WorldDBQuery(" SELECT entry FROM arc_mercs.mercenaries WHERE ownerGuid = '"..data.."' and groupId = "..group.."  ")
	
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

	unit:GossipCreateMenu( 1, plr, 0 )
	
	unit:GossipMenuAddItem( 1, "I want a Soldier.", 0, 0 )
	
	unit:GossipMenuAddItem( 1, "I need a Healer.", 1, 0 )
	
	unit:GossipMenuAddItem( 1, "Give me an Officer.", 2, 0 )
	
	unit:GossipMenuAddItem( 0, "Reset.", 3, 0 )
	
	unit:GossipSendMenu( plr )

end

function ARCMERCS.MasterOnSelection( unit, event, plr, id, intid, code )

	local data = tostring( plr:GetGUID() )
	
	local level = plr:GetLevel()
	
	local coins = plr:GetCoinage()
	
	if( intid == 0 ) then
	
		if getMercCount( plr, 0 ) < 3 then
		
			if( coins > 10 ) then
			
				local e = soldierId[ plr:GetTeam() + 1 ]
				
				WorldDBQuery(" INSERT INTO arc_mercs.mercenaries (ownerGuid, groupId, entry, ownerName, type) VALUES ('"..tostring(data).."', 0, "..e..", '"..plr:GetName().."', 'Soldier' ) ")
				
				local merc = plr:CreateGuardian( e, 0, math.random( 1, 6 ), level )
				
				unit:SendChatMessage( 12, 0, "Take your Soldier." )

			else
			
				unit:SendChatMessage( 12, 0, "I apologize, "..plr:GetName().." but you do not have the amount of money I require." );
			
			end
			
		else
		
			unit:SendChatMessage( 12, 0, "Im sorry, "..plr:GetName().." but i cant spare more than three Soldiers for each hero." )
		
		end
		
	end

	if( intid == 1 ) then
	
		unit:SendChatMessage( 12, 0, "Take your Healer." )
	
	end
	
	if( intid == 2 ) then
	
		unit:SendChatMessage( 12, 0, "Take your Officer." )
	
	end
	
	if( intid == 3 ) then
	
		WorldDBQuery(" DELETE FROM arc_mercs.mercenaries WHERE ownerGuid = '"..tostring(data).."' ")
	
		unit:SendChatMessage( 12, 0, "Your mercenary info has been reseted." )
	
	end
	
	plr:GossipComplete()
	
end

RegisterUnitGossipEvent( 43283, 1, ARCMERCS.MasterOnHello );
RegisterUnitGossipEvent( 43283, 2, ARCMERCS.MasterOnSelection );