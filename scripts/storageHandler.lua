ARCMERCS = {}

--- LoadMercsOnMapChange
---   This function loads all mercenaries of a player when enter world or map change.
---
--- Parameter(s)
---   event
---   plr
---
--- Return value
---   None.
---
function ARCMERCS.LoadMercsOnMapChange( event, plr )

	local p = tostring(plr:GetGUID())
	
	local result = WorldDBQuery("SELECT entry, display, angle, stance FROM arcmercs.mercenaries WHERE ownerGuid = '"..p.."' AND groupId = 1")
	
	if result then
	
		local rowcount = result:GetRowCount()
		
		local level = plr:GetLevel()
		
		local id = 0
		
		repeat
			
			rowcount = rowcount - 1
			
			local entry = result:GetColumn( 0 ):GetUShort()
			
			local display = result:GetColumn( 1 ):GetULong()
			
			local angle = result:GetColumn( 2 ):GetFloat()
			
			if entry ~= 0 then
			
				local merc = plr:CreateGuardian( entry, 0, angle, level ) -- duration = 0 for never despawn
				
				merc:SetModel( display )
				
				--merc:EquipWeapons( 1899, 143, 1 )
				
				if stance ~= 0 then
				
					local q = WorldDBQuery("SELECT slot1, slot2, slot3 FROM arcmercs.weapons WHERE entry = "..entry.." AND display = "..merc:GetDisplay().." AND stance = "..stance.."")
					
					if q then
					
						merc:EquipWeapons( q:GetColumn( 0 ):GetULong(), q:GetColumn( 1 ):GetULong(), q:GetColumn( 2 ):GetULong() )
						
					end
					
				end				
				
				merc:SetByteValue( 0x7A, 0, 1 ) -- set weapons at hand 
				
				local m = tostring(merc:GetGUID())

				if entry == 43284 or entry == 43284 then
				
					id = id + 1
				
					WorldDBQuery("UPDATE arcmercs.mercenaries SET mercGuid = '"..m.."' WHERE ownerGuid = '"..p.."' AND groupId = 1 AND id = '"..id.."'")
					
				end
				
			end
			
			result:NextRow()
		
		until rowcount == 0
		
		print("[ArcMercs]: mercenaries of "..plr:GetName().." loaded. ") -- for debug
		
	end	
	
end

RegisterServerHook( 4, ARCMERCS.LoadMercsOnMapChange );