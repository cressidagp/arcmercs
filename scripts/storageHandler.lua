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

	local data = tostring(plr:GetGUID())
	
	local result = WorldDBQuery("SELECT entry, display FROM arcmercs.mercenaries WHERE ownerGuid = '"..data.."' AND groupId = 1")
	
	if result then
	
		local rowcount = result:GetRowCount()
		
		local level = plr:GetLevel()
		
		repeat
			
			rowcount = rowcount - 1
			
			local entry = result:GetColumn( 0 ):GetUShort()
			
			local display = result:GetColumn( 1 ):GetULong()

			if entry ~= 0 then
			
				local merc = plr:CreateGuardian( entry, 0, math.random( 0, 5 ), level )
				
				merc:SetModel( display )
				
				--merc:EquipWeapons( 1899, 143, 1 );
				
			end
			
			result:NextRow()
		
		until rowcount == 0
		
	end	
	
end

RegisterServerHook( 4, ARCMERCS.LoadMercsOnMapChange );