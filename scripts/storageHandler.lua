ARCMERCS = {}

--- LoadMercsOnMapChange()
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

	local data = plr:GetGUID()
	
	local result = WorldDBQuery(" SELECT entry FROM arc_mercs.mercenaries WHERE ownerGuid = '"..tostring(data).."' and groupId = 0 ")
	
	if result then
	
		local rowcount = result:GetRowCount()
		
		local level = plr:GetLevel()
		
		repeat
			
			rowcount = rowcount - 1
			
			local entry = result:GetColumn( 0 ):GetUShort()

			if entry ~= 0 then
			
				local merc = plr:CreateGuardian( entry, 0, math.random( 1, 6 ), level )
				
				--merc:EquipWeapons( 1899, 143, 1 );
				
			end
			
			result:NextRow()
		
		until rowcount == 0
		
	end	
	
end

RegisterServerHook( 4, ARCMERCS.LoadMercsOnMapChange );