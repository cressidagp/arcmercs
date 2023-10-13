--[[
	ArcMercs for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Credits:
	
	*) Halestorm original idea.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	Developer notes:
	
SetUnitToFollow( plr, dist, angle );

CREATE TABLE `merc` (
  `guid` int(6) unsigned NOT NULL DEFAULT '0',
  `name` varchar(21) NOT NULL DEFAULT '',
  `slot1entry` int(6) unsigned NOT NULL DEFAULT '0',
  `slot2entry` int(6) unsigned NOT NULL DEFAULT '0',
  `slot3entry` int(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';

--]]

ARCMERCS = {};

function ARCMERCS.LoadMercs( event, plr )

	local data = tostring( plr:GetGUID() );
	
	local result = CharDBQuery( "SELECT `slot1entry`, `slot2entry`, `slot3entry` FROM `merc` WHERE `guid` = '"..data.."'" );
	
	if( result ~= nil )
	
	then
	
		local colcount = result:GetColumnCount();
		
		repeat
		
			colcount = colcount - 1;
			
			local spid = result:GetColumn( colcount ):GetUShort();
			
			local level = plr:GetLevel();
			
			if( spid ~= 0 )
			
			then
				
				local merc = plr:CreateGuardian( spid, 0, math.random( 1, 6 ), level );
				
				merc:EquipWeapons( 1899, 143, 1 );
				
			end
		
		until colcount == 0;	
	
	else
	
		CharDBQuery( "INSERT INTO `merc` VALUES ('"..data.."', '"..plr:GetName().."', 0, 0, 0)" );
		
	end
	
end

RegisterServerHook( 4, ARCMERCS.LoadMercs );