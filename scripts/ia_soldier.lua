-- local EMOTE_ONESHOT_EAT = 7
-- local EMOTE_ONESHOT_FLEX = 23
-- local EMOTE_ONESHOT_DANCE = 94
-- local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008

ARCMERCS = {}
ARCMERCS.SOLDIER = {}

function ARCMERCS.SOLDIER.OnSpawn( unit, event )

	-- not start aiupdate if merc dont have owner
	if unit:GetUInt64Value( 0x0006 + 0x0008 ) ~= nil then

		unit:RegisterAIUpdateEvent( 1000 )
		
	end

end

function ARCMERCS.SOLDIER.OnAggro( unit, event, attacker )
	
	-- soldier has 'battle stance'
	if ARCMERCS[tostring(unit)].SOLDIER_STANCE == 1 then
		
		-- check if enemy is in range
		if unit:GetDistanceYards( attacker ) < 27 then

			-- cast 'charge' on attacker
			unit:CastSpellOnTarget( 100, attacker )
			
		end
		
	end

end

function ARCMERCS.SOLDIER.OnAIUpdate( unit, event )

	print("AI update")

	--
	-- merc its idle
	--


	-- 
	-- merc its attacking
	--
	
	if unit:GetAIState() == 1 then
	
		local target = unit:GetUInt64Value( 0x0006 + 0x000C )
		
		if target == nil then return; end
	
		if ARCMERCS[tostring(unit)].SOLDIER_STANCE == 1 then
		
			print("stance1")
	
		elseif ARCMERCS[tostring(unit)].SOLDIER_STANCE == 2 then
		
			print("stance2")
	
		else
		
			print("stance3")
		
		end
	
	end
	
	--
	-- merc its casting
	--

	if unit:GetAIState() == 2 then return; end
	
	--
	-- merc its following
	--

	if unit:GetAIState() == 4 then
	
		local f = math.random( 0, 100 )
		
		if( f > 0 and f <= 2 ) then
		
			unit:CastSpell( 433 ) -- eat
			
		elseif( f > 2 and f <= 5 ) then
		
			unit:Emote( 23, 0 ) -- flex
			
		elseif( f > 5 and f <= 8 ) then
		
			unit:Emote( 16, 0 ) -- dance
			
		elseif( f > 8 and f <= 10 ) then
		
			unit:CastSpell( 430 ) -- drink
		
		end	
	
	end

end

function ARCMERCS.SOLDIER.OnLeaveCombat( unit, event, target )

	--unit:RemoveAIUpdateEvent()

end

function ARCMERCS.SOLDIER.OnTargetDied( unit, event, target )

	--unit:RemoveAIUpdateEvent()

end

function ARCMERCS.SOLDIER.OnDied( unit, event, killer )

	-- Not need to RemoveAIUpdateEvent() here since its auto handled

end

RegisterUnitEvent( 43284, 18, ARCMERCS.SOLDIER.OnSpawn );
RegisterUnitEvent( 43285, 18, ARCMERCS.SOLDIER.OnSpawn );

RegisterUnitEvent( 43284, 1, ARCMERCS.SOLDIER.OnAggro );
RegisterUnitEvent( 43285, 1, ARCMERCS.SOLDIER.OnAggro );

RegisterUnitEvent( 43284, 2, ARCMERCS.SOLDIER.OnLeaveCombat );
RegisterUnitEvent( 43285, 2, ARCMERCS.SOLDIER.OnLeaveCombat );

RegisterUnitEvent( 43284, 3, ARCMERCS.SOLDIER.OnTargetDied );
RegisterUnitEvent( 43285, 3, ARCMERCS.SOLDIER.OnTargetDied );

RegisterUnitEvent( 43284, 4, ARCMERCS.SOLDIER.OnDied );
RegisterUnitEvent( 43285, 4, ARCMERCS.SOLDIER.OnDied );

RegisterUnitEvent( 43284, 21, ARCMERCS.SOLDIER.OnAIUpdate );
RegisterUnitEvent( 43285, 21, ARCMERCS.SOLDIER.OnAIUpdate );