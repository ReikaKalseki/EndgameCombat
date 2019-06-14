require "constants"
require "plasmabeam"
require "functions"

function doLastStandDestruction(turret)
	--game.print("Doing last stand @ " .. turret.position.x .. " , " .. turret.position.y)
	local entities = turret.surface.find_entities_filtered({area = {{turret.position.x-20, turret.position.y-20}, {turret.position.x+20, turret.position.y+20}}})
	for _,entity in pairs(entities) do
		if entity.force == game.forces.enemy and getDistance(entity, turret) <= 22 then
			entity.surface.create_entity({name="blood-explosion-small", position=entity.position, force=entity.force})
			entity.damage(5000, turret.force, "acid")
			if entity.valid then entity.damage(5000, turret.force, "fire") end
			if entity.valid then entity.damage(5000, turret.force, "explosion") end
			turret.damage_dealt = turret.damage_dealt+15000
			turret.kills = turret.kills+1
		else
			if entity.health then
				entity.damage(entity.health*(0.25+math.random()*0.25), turret.force, "acid")
			end
		end
	end
	turret.surface.create_entity({name = "orbital-bombardment-explosion", position = turret.position, force = game.forces.neutral})
end

local function clearTurretTarget(turret) --not possible right now
	--turret.shooting_target = nil --cannot assign nil (yet?)
	
	--if turret.shooting_target and turret.shooting_target.name == "laser-turret" then return end
	--local dummy = turret.surface.create_entity({name = "laser-turret", position = {turret.position.x+25, turret.position.y-25}, force = game.forces.enemy})
	--turret.shooting_target = dummy
	
	--turret.orientation = turret.orientation+0.05 --ranges from 0 to 1
	
	--turret.active = false
end

function getLightningRechargeTime(force)
	local lvl = 1
	while force.technologies["lightning-turret-charging-" .. lvl].researched and lvl < 5 do
		lvl = lvl+1
	end
	return LIGHTNING_TURRET_RECHARGE_TIME-lvl*LIGHTNING_TURRET_RECHARGE_TIME_REDUCTION_PER_TECH
end

function rechargeLightningTurret(egcombat, entity)
	if egcombat.lightning_turrets[entity.force.name] and egcombat.lightning_turrets[entity.force.name][entity.unit_number] then
		egcombat.lightning_turrets[entity.force.name][entity.unit_number].last_fire_time = game.tick
		egcombat.lightning_turrets[entity.force.name][entity.unit_number].last_fire_direction = entity.orientation
	end
end

function tickLightningTurret(egcombat, entry, tick)
	local mintime = getLightningRechargeTime(entry.turret.force)-entry.delay*2

	if entry.turret.energy < LIGHTNING_TURRET_DISCHARGE_ENERGY then
		entry.last_fire_time = tick
		entry.played_charge_sound = false
		if not entry.played_discharge_sound and tick-entry.last_fire_time >= 20 then
			entry.turret.surface.create_entity{name = "lightning-discharge-sound", position = entry.turret.position}	
			entry.played_discharge_sound = true
		end
	elseif not entry.played_charge_sound then
		entry.turret.surface.create_entity{name = "lightning-charge-sound", position = entry.turret.position}
		entry.played_charge_sound = true	
		entry.played_discharge_sound = false
	end
	
	if entry.last_fire_time and tick-entry.last_fire_time < mintime then
		if entry.last_fire_direction then
			entry.turret.orientation = entry.last_fire_direction
		end
		clearTurretTarget(entry.turret)
		return
	end
	
	if entry.turret.shooting_target and entry.turret.shooting_target.health < LIGHTNING_TURRET_HEALTH_THRESHOLD then
		--game.print("Turret is currently targeting " .. entry.turret.shooting_target.name)
		clearTurretTarget(entry.turret)
		return
	end
	
	if tick%entry.delay == 0 and entry.turret.energy >= LIGHTNING_TURRET_DISCHARGE_ENERGY and tick-entry.last_fire_time >= mintime then
		--game.print("Running lightning targeting code.")
		if entry.turret.shooting_target and entry.turret.shooting_target.valid and entry.turret.shooting_target.health > 0 then --do not need to check range; vanilla does that automatically
			if entry.turret.shooting_target.health >= LIGHTNING_TURRET_HEALTH_THRESHOLD then --was it locked onto an invalid target
				--game.print("Lightning turret already has a target.")
			else
				clearTurretTarget(entry.turret)
			end
			return
		end
		local dr = getTurretRangeBoost(egcombat, entry.turret.force)
		--game.print("Ticking turret @ " .. entry.turret.position.x .. "," .. entry.turret.position.y)
		local scan = entry.delay >= 60
		local search = LIGHTNING_TURRET_SCAN_RADIUS+dr
		if scan then
			search = search+5
		end
		local enemies = entry.turret.surface.find_enemy_units(entry.turret.position, search, entry.turret.force)
		if #enemies > 0 then
			--game.print(#enemies .. " @ " .. entry.delay .. " > " .. (scan and "scanning" or "acting"))
			if not scan then
				local strongest = nil
				for _,biter in pairs(enemies) do
					if biter.valid and biter.health >= LIGHTNING_TURRET_HEALTH_THRESHOLD then
						local d = getDistance(biter, entry.turret)
						if d <= LIGHTNING_TURRET_RANGE+dr then
							if strongest == nil or biter.health > strongest.health then
								strongest = biter
							end
						end
					end
				end
				if strongest then
					local last = entry.turret.shooting_target
					entry.turret.shooting_target = strongest
					--game.print("Locking on " .. strongest.name .. --[[" @ " .. strongest.position.x .. " , " .. strongest.position.y .. --]]" ; last = " .. (last and (last.name --[[.. " @ " .. last.position.x .. " , " .. last.position.y--]]) or "nil"))
					entry.turret.active = true
				else
					clearTurretTarget(entry.turret)
				end
			end
			entry.delay = math.max(10, entry.delay-15)
		else
			entry.delay = math.min(90, entry.delay+10)
		end
	end
end

function tickCannonTurret(egcombat, entry, tick)
	if tick%entry.delay == 0 and (not entry.turret.get_inventory(defines.inventory.turret_ammo).is_empty()) then
		if entry.turret.shooting_target and entry.turret.shooting_target.valid and entry.turret.shooting_target.health > 0 and string.find(entry.turret.shooting_target.name, "spitter", 1, true) then
			return
		end
		--game.print("Ticking turret @ " .. entry.turret.position.x .. "," .. entry.turret.position.y)
		local scan = entry.delay >= 60
		local search = CANNON_TURRET_RANGE+getTurretRangeBoost(egcombat, entry.turret.force)
		if scan then
			search = search+5
		end
		local enemies = entry.turret.surface.find_enemy_units(entry.turret.position, search, entry.turret.force)
		if #enemies > 0 then
			--game.print(#enemies .. " @ " .. entry.delay .. " > " .. (scan and "scanning" or "acting"))
			if not scan then
				for _,biter in pairs(enemies) do
					if biter.valid and biter.health > 0 then
						local d = getDistance(biter, entry.turret)
						if d <= CANNON_TURRET_RANGE and d >= CANNON_TURRET_INNER_RANGE then
							if string.find(biter.name, "spitter", 1, true) then
								local last = entry.turret.shooting_target
								entry.turret.shooting_target = biter
								--game.print("Locking on " .. biter.name .. --[[" @ " .. biter.position.x .. " , " .. biter.position.y .. --]]" ; last = " .. (last and (last.name --[[.. " @ " .. last.position.x .. " , " .. last.position.y--]]) or "nil"))
								break
							end
						end
					end
				end
			end
			entry.delay = math.max(10, entry.delay-15)
		else
			entry.delay = math.min(90, entry.delay+10)
		end
	end
end

function tickShockwaveTurret(egcombat, entry, tick)
	if tick%entry.delay == 0 and entry.turret.energy >= SHOCKWAVE_TURRET_DISCHARGE_ENERGY then
		--game.print("Ticking turret @ " .. entry.turret.position.x .. "," .. entry.turret.position.y)
		local scan = entry.delay >= 40 or tick%(12*entry.delay) == 0
		--game.print(entry.delay .. " -> " .. (scan and "scan" or "flat"))
		local enemies = entry.turret.surface.find_enemy_units(entry.turret.position, (scan and SHOCKWAVE_TURRET_SCAN_RADIUS or SHOCKWAVE_TURRET_RADIUS)+getShockwaveRangeBoost(egcombat, entry.turret.force)+getTurretRangeBoost(egcombat, entry.turret.force), entry.turret.force)
		if #enemies > 0 then
			local flag = false
			local f = getShockwaveTurretDamageFactor(entry.turret.force)
			--game.print(#enemies .. " @ " .. entry.delay .. " > " .. (scan and "true" or "false"))
			for _,biter in pairs(enemies) do
				if biter.valid and biter.health > 0 then
					local d = getDistance(biter, entry.turret)
					if ((not scan) or d <= SHOCKWAVE_TURRET_RADIUS) then
						local cap = math.max(10, 50*math.min(1, 1-math.ceil((d-5)/5)))
						flag = true
						local pos = biter.position
						local force = biter.force
						entry.turret.surface.create_entity({name="shockwave-beam", position=entry.turret.position, force=entry.turret.force, target=biter, source=entry.turret})
						--game.print("Attacking biter @ " .. biter.position.x .. "," .. biter.position.y)
						local maxh = game.entity_prototypes[biter.name].max_health
						local dmg = maxh < 20 and 4*(1+(f-1)*1.5) or math.min(cap*(1+(f-1)*2), math.max(3, math.min(maxh/2, maxh*f/10)))
						biter.damage(dmg, entry.turret.force, "electric")
						if scan or tick%(6*entry.delay) == 0 or (not biter.valid) or biter.health <= 0 then
							entry.turret.surface.create_entity({name="blood-explosion-small", position=pos, force=force})
						end
						entry.turret.damage_dealt = entry.turret.damage_dealt+dmg
						if not biter.valid or biter.health <= 0 then
							entry.turret.kills = entry.turret.kills+1
						end
					elseif scan then
						biter.set_command({type = defines.command.compound, structure_type = defines.compound_command.logical_and, commands = {{type = defines.command.go_to_location, distraction = defines.distraction.none, destination = entry.turret.position}, {type = defines.command.attack, distraction = defines.distraction.none, target = entry.turret}}})
					end
				end
			end
			entry.delay = math.max(10, entry.delay-10)
			if flag then
				entry.turret.energy = entry.turret.energy-SHOCKWAVE_TURRET_DISCHARGE_ENERGY
				entry.turret.surface.create_entity({name="shockwave-turret-effect", position={entry.turret.position.x-2+math.random()*4, entry.turret.position.y-2+math.random()*4}, force=entry.turret.force})
			end
		else
			entry.delay = math.min(60, entry.delay+5)
		end
	end
end

function getShockwaveTurretDamageFactor(force)
	if not force.technologies["shockwave-turret-damage-1"].researched then return 1 end
	local level = 1
	for i = 5, 1, -1 do
		if force.technologies["shockwave-turret-damage-" .. i].researched then
			level = i
			break
		end
	end
	return 1+level*0.4
end

function repairTurret(turret, tier)
	local maxhealth = game.entity_prototypes[turret.name].max_health
	local health = turret.health
	local maxrepair = maxhealth-health
	if maxrepair > 0 then
		local repair = math.max(1, math.min(REPAIR_LIMITS[tier], math.floor(REPAIR_FACTORS[tier]*maxrepair)))
		if repair > 0 then
			turret.health = turret.health + repair
		end
	end
end

function repairTurrets(egcombat, force)
	local level = 1
	for i = #REPAIR_CHANCES, 1, -1 do
		if force.technologies["healing-alloys-" .. i].researched then
			level = i
			break
		end
	end
	--game.print(#egcombat.placed_turrets[force.name])
	if egcombat.placed_turrets[force.name] == nil then
		egcombat.placed_turrets[force.name] = {}
	end
	for k,entry in pairs(egcombat.placed_turrets[force.name]) do
		if entry.turret.valid and math.random() < REPAIR_CHANCES[level] then
			repairTurret(entry.turret, level)
		end
	end
end

local function simpleInterpolation(w1, v1, w2, v2)
	return (v1*w1 + v2*w2)/(w1+w2)
end

local function getUnitHealth(unit)
	local health = game.entity_prototypes[unit].max_health
	local res = game.entity_prototypes[unit].resistances
	if res and res[damage] and res[damage].percent then --simplified
		health = health*(1+res[damage].percent*2)
	end
	return health
end

--roughly aligns to spawn curve: 0-0.3 = small only; 0.3-0.5 adds medium,0.5-0.9 adds big, 0.9+ = behemoth
local function getAverageEnemyHealth(damage) --move this to a proper linear interpolate in 0.17 when can have centralized reference - probably want to cache into an array (2.5% granularity) for performance
	local evo = game.forces.enemy.evolution_factor
	local unit = nil
	if evo < 0.3 then
		return getUnitHealth("small-biter")
	elseif evo < 0.5 then
		return simpleInterpolation(0.5-evo,getUnitHealth("small-biter"),evo-0.3,getUnitHealth("medium-biter"))
	elseif evo < 0.9 then
		return simpleInterpolation(0.9-evo,getUnitHealth("medium-biter"),evo-0.5,getUnitHealth("big-biter"))
	else
		return simpleInterpolation(1.2-evo,getUnitHealth("big-biter"),evo-0.9,getUnitHealth("behemoth-biter"))--only ~33% behemoths at maximum evolution
	end
end

function handleTurretLogistics(egcombat, force)
	local auto = force.technologies["turret-auto-logistics"].researched
	--game.print(#egcombat.placed_turrets[force.name])
	if egcombat.placed_turrets[force.name] == nil then
		egcombat.placed_turrets[force.name] = {}
	end
	for k,entry in pairs(egcombat.placed_turrets[force.name]) do
		if entry.turret.valid and entry.logistic then
			local inv = entry.turret.get_inventory(defines.inventory.turret_ammo)
			local logi = entry.logistic.get_inventory(defines.inventory.chest)
			if auto then
				if inv[1] and inv[1].valid_for_read then
					--local amt = math.min(100, math.max(5, math.ceil(inv[1].prototype.stack_size/2)))
					--if entry.turret.type == "artillery-turret" then
					--	amt = math.max(2, amt/4)
					--end
					--entry.logistic.set_request_slot({name=inv[1].name, count=amt}, 1)
					local shots = inv[1].count*inv[1].prototype.magazine_size
					local info = inv[1].prototype.get_ammo_type("turret")
					local per, type = getAmmoTypeDamage(info)
					per = per*entry.turret.prototype.attack_parameters.damage_modifier
					local tech1 = 1+entry.turret.force.get_ammo_damage_modifier(info.category)
					local tech2 = 1+entry.turret.force.get_turret_attack_modifier(entry.turret.name)
					--game.print("Modifier " .. tech1 .. " for " .. info.category .. " and " .. tech2 .. " for turret")
					local per2 = per*tech1*tech2
					local lowAmmoThreshold = getAverageEnemyHealth(damage)*25
					local requested = lowAmmoThreshold*2/per2/shots
					entry.logistic.set_request_slot({name=inv[1].name, count=math.max(0,math.min(100, math.max(5, math.ceil(requested)))-inv[1].count-(inv[2] and inv[2].valid_for_read and inv[2].count or 0))}, 1)
				else
					entry.logistic.clear_request_slot(1)
				end
			end
			if logi[1] and logi[1].valid_for_read and logi[1].prototype.magazine_size then --check if ammo
				local n = logi[1].name
				local add = inv.insert({name=n, count=logi[1].count, ammo=logi[1].ammo})
				if add > 0 then
					logi.remove({name=n, count=add})
				end
			end
		end
	end
end
