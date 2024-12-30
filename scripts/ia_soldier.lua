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
	
	local sUnit = tostring(unit)
	
	ARCMERCS[tostring(sUnit)] = {
		
		spellTimer = math.random( 6, 10 ),
		spellNumber = 1
		
	};

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
	
		unit:SendChatMessage( 12, 0, "state: attacking" ) -- for debug
	
		local target = unit:GetUInt64Value( 0x0006 + 0x000C )
		
		-- dont bother with this if no target
		if target == nil then return; end
		
		local sUnit = tostring(unit)
		
		ARCMERCS[sUnit].spellTimer = ARCMERCS[sUnit].spellTimer - 1
		
		if ARCMERCS[sUnit].spellTimer <= 0 then
			
			local s = ARCMERCS[sUnit].soldierStance
			local n = ARCMERCS[sUnit].spellNumber
			local lv = unit:GetLevel()
			
			local q = WorldDBQuery("SELECT spellId, target FROM arcmercs.spells WHERE entry = "..unit:GetEntry().." AND stance = "..s.." AND slot = "..n.." AND minlv <= "..lv.." AND maxlv >= "..lv.." ")
			
			if q then
			
				local value = q:GetColumn( 1 ):GetShort()
			
				if value == 0 then
				
					unit:CastSpell( q:GetColumn( 0 ):GetULong() )
				
				elseif value == 1 then
				
					local target = unit:GetMainTank()
					
					if target then
				
						unit:CastSpellOnTarget( q:GetColumn( 0 ):GetULong(), target )
						
					end
				
				end
			
				ARCMERCS[sUnit].spellTimer = math.random( 6, 10 )
				
			end
			
			ARCMERCS[sUnit].spellSlot = ARCMERCS[sUnit].spellSlot + 1
			
			if ARCMERCS[sUnit].spellSlot == 5 then
			
				ARCMERCS[sUnit].spellSlot = 1
			
			end

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