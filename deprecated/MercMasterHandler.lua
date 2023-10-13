--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	Developer notes:

CREATE TABLE `merc` (
  `guid` int(6) unsigned NOT NULL DEFAULT '0',
  `name` varchar(21) NOT NULL DEFAULT '',
  `slot1entry` int(6) unsigned NOT NULL DEFAULT '0',
  `slot2entry` int(6) unsigned NOT NULL DEFAULT '0',
  `slot3entry` int(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';

	ToDo:
	
	*) find proper display id
	*) save and create guardian with different entrys for horde and alliance

--]]

ARCMERCS = {};

entry = { 43284, 43285 };

function ARCMERCS.MasterOnHello( unit, event, plr )

	unit:GossipCreateMenu( 1, plr, 0 );
	
	unit:GossipMenuAddItem( 1, "I want a Soldier.", 1, 0 );
	
	unit:GossipMenuAddItem( 1, "Give me an Officer.", 2, 0 );
	
	unit:GossipMenuAddItem( 1, "I need a healer.", 3, 0 );
	
	unit:GossipMenuAddItem( 0, "Reset.", 4, 0 );
	
	unit:GossipSendMenu( plr );
end

function ARCMERCS.MasterOnSelection( unit, event, plr, id, intid, code )

	local data = tostring( plr:GetGUID() );
	
	if( intid == 1 )
	
	then
	
		local result = WorldDBQuery( "SELECT `slot1entry`, `slot2entry`, `slot3entry` FROM `merc` WHERE `guid` = '"..data.."'" );
		
		if( result ~= nil )
		
		then
		
			if( result:GetColumn( 2 ):GetUShort() ~= 0 and result:GetColumn( 1 ):GetUShort() ~= 0 and result:GetColumn( 0 ):GetUShort() ~= 0 )
			
			then 
			
				unit:SendChatMessage( 12, 0, "Im sorry, "..player:GetName().." but you cant have more than three soldiers." );
				
				return; end
				
			if( plr:GetCoinage() < 10 )
			
			then
		
				unit:SendChatMessage( 12, 0, "I apologize, "..player:GetName().." but you do not have the amount of money I require." );
				
				return; end
			
			local colcount = result:GetColumnCount();
			
			local i = plr:GetTeam() + 1;
			
			repeat
			
				colcount = colcount - 1;
				
				local spid = result:GetColumn( colcount ):GetUShort();
				
				if( spid == 0 )
				
				then
				
					if( colcount == 2 )
					
					then
					
						CharDBQuery( "UPDATE `merc` SET `slot3entry` = '"..entry[ i ].."' WHERE `guid` = '"..data.."'" );
				
					elseif( colcount == 1 )
					
					then
					
						CharDBQuery( "UPDATE `merc` SET `slot2entry` = '"..entry[ i ].."' WHERE `guid` = '"..data.."'" );
						
					elseif( colcount == 0 )
					
					then
					
						CharDBQuery( "UPDATE `merc` SET `slot1entry` = '"..entry[ i ].."' WHERE `guid` = '"..data.."'" );
						
					end
					
					local merc = plr:CreateGuardian( entry[ i ], 0, math.random( 1, 6 ), plr:GetLevel() );
					
					merc:EquipWeapons( 1899, 143, 1 );
					
					unit:SendChatMessage( 12, 0, "Take your Soldier." );
					
					break;
					
				end
				
			until colcount == 0;
			
		end

	elseif( intid == 2 )
	
	then
	
		unit:SendChatMessage( 12, 0, "Take your Officer." );
		
	elseif( intid == 3 )
	
	then
	
		unit:SendChatMessage( 12, 0, "Take your Medic." );

	else
	
		CharDBQuery( "UPDATE `merc` SET `slot1entry` = '0', `slot2entry` = '0', `slot3entry` = '0' WHERE `guid` = '"..data.."'" );
		
		unit:SendChatMessage( 12, 0, "Your mercenary info has been reseted." );
		
	end

	plr:GossipComplete();
	
end

RegisterUnitGossipEvent( 43283, 1, ARCMERCS.MasterOnHello );

RegisterUnitGossipEvent( 43283, 2, ARCMERCS.MasterOnSelection );