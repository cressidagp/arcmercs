--local EMOTE_ONESHOT_TALK = 1
--local EMOTE_ONESHOT_EAT = 7
--local EMOTE_ONESHOT_FLEX = 23
--local EMOTE_ONESHOT_DANCE = 94
--local SPELL_CHARGE = 100
--local SPELL_DRINK = 430
--local SPELL_EAT = 433
--local OBJECT_END = 0x0006
--local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C
--local UNIT_FIELD_BYTES_0 = 0x0006 + 0x0011
--local UNIT_FIELD_BYTES_1 = 0x0006 + 0x0044
--local UNIT_FIELD_BYTES_2 = 0x0006 + 0x0074 

ARCMERCS = {}
ARCMERCS.SOLDIER = {}

math.randomseed(os.time()); math.random(); math.random(); math.random();

function ARCMERCS.SOLDIER.OnSpawn( unit, event )

	-- not start aiupdate if merc dont have owner
	if unit:GetUInt64Value( 0x0006 + 0x0008 ) ~= nil then

		unit:RegisterAIUpdateEvent( 2000 )
		
	end

end

function ARCMERCS.SOLDIER.OnAggro( unit, event, attacker )
	
	-- soldier has 'battle stance'
	if ARCMERCS[tostring(unit)].soldierStance == 1 then
		
		-- check if enemy is in range
		if unit:GetDistanceYards( attacker ) < 27 then

			-- cast 'charge' on attacker
			unit:CastSpellOnTarget( 100, attacker )
			
		end
		
	end

end

function ARCMERCS.SOLDIER.OnAIUpdate( unit, event )

	--
	-- merc its idle
	--

	if unit:GetAIState() == 0 then
	
		if unit:GetByteValue( 0x0006 + 0x0044, 0 ) ~= 1 then
		
			-- sit on the ground
			unit:SetByteValue( 0x0006 + 0x0044, 0, 1 )
			
		end
		
	end

	-- 
	-- merc its attacking
	--
	
	if unit:GetAIState() == 1 then
	
		local target = unit:GetUInt64Value( 0x0006 + 0x000C )
		
		-- dont bother with this if no target
		if target == nil then return; end
	
		if ARCMERCS[tostring(unit)].soldierStance == 1 then
		
			print("stance1")
	
		elseif ARCMERCS[tostring(unit)].soldierStance == 2 then
		
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
	
		if unit:GetByteValue( 0x0006 + 0x0044, 0 ) ~= 0 then
		
			-- stand up
			unit:SetByteValue( 0x0006 + 0x0044, 0, 0 )
			
		end
	
		-- dont bother with this if merc its moving
		if unit:IsCreatureMoving() == true then return; end
		
		-- dont bother with this if eating of drinking
		if unit:HasAura( 430 ) or unit:HasAura( 433 ) then return; end
		
		if unit:GetHealthPct() < 35 then
		
			unit:CastSpell( 433 )
			
		end
	
		local f = math.random( 0, 100 )
		
		if( f > 0 and f <= 15 ) then
		
			unit:Emote( 1, 0 ) -- talk
	
		elseif( f > 20 and f <= 22 ) then
		
			unit:Emote( 23, 0 ) -- flex
			
		elseif( f > 31 and f <= 33 ) then
		
			unit:Emote( 16, 0 ) -- dance

		else
		
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