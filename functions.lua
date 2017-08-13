require "constants"
require "plasmabeam"

function Radar_Defence(factor)
return
    {
      {
         --how far the mirroring works
        range = (15+5*factor)--[[*global.EndgameCombatVars.robotDefenceLevelBoostFactor--]],
         --what kind of damage triggers the mirroring
         --if not present then anything triggers the mirroring
        --damage_type = {"physical", "acid", "biological"},
         --caused damage will be multiplied by this and added to the subsequent damages
        reaction_modifier = factor--[[*global.EndgameCombatVars.robotDefenceLevelBoostFactor--]],
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              type = "damage",
               --always use at least 0.1 damage
              damage = {amount = 0.1, type = "laser"}
            }
          }
        },
      }
    }
end

function Robot_Defence(factor)
return
    {
      {
         --how far the mirroring works
        range = (15+5*factor)--[[*global.EndgameCombatVars.robotDefenceLevelBoostFactor--]],
         --what kind of damage triggers the mirroring
         --if not present then anything triggers the mirroring
        --damage_type = {"physical", "acid", "biological"},
         --caused damage will be multiplied by this and added to the subsequent damages
        reaction_modifier = factor/1.25--[[*global.EndgameCombatVars.robotDefenceLevelBoostFactor--]],
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              type = "damage",
               --always use at least 0.1 damage
              damage = {amount = 0.1, type = "laser"}
            }
          }
        },
      }
    }
end

function Electric_Pole_Defence(factor)
return
    {
      {
         --how far the mirroring works
        range = 4--[[*global.EndgameCombatVars.poleDefenceLevelBoostFactor--]],
         --what kind of damage triggers the mirroring
         --if not present then anything triggers the mirroring
        --damage_type = {"physical", "acid", "biological"},
         --caused damage will be multiplied by this and added to the subsequent damages
        reaction_modifier = 0.01--[[factor--]]--[[*global.EndgameCombatVars.robotDefenceLevelBoostFactor--]],
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              type = "damage",
               --always use at least 0.1 damage
              damage = {amount = 20*factor*factor, type = "electric"}
            }
          }
        },
      }
    }
end

function addCategoryResistance(category, type_, reduce, percent)
	if not data.raw[category] then error("No such category '" .. category .. "'!") end
	for k,v in pairs(data.raw[category]) do
		addResistance(category, k, type_, reduce, percent)
	end
end

function addResistance(category, name, type_, reduce, percent)
	local obj = data.raw[category][name]
	if obj.resistances == nil then
		obj.resistances = {}
	end
	local resistance = createResistance(type_, reduce, percent)
	for k,v in pairs(obj.resistances) do
		if v["type"] == type_ then --if resistance to that type already present, overwrite rather than have two for same type
			v["decrease"] = reduce
			v["percent"] = percent
			return
		end
	end
	table.insert(data.raw[category][name].resistances, resistance)
end

function createResistance(type_, reduce, percent_)
return
{
        type = type_,
		decrease = reduce,
        percent = percent_
}
end

function Modify_Power(train, factor)
	local obj = data.raw["locomotive"][train]
	local pow = obj.max_power
	local num = string.sub(pow, 1, -3)
	local endmult = string.sub(pow, -2, -1)
	local newpow = num*factor
	obj.max_power = newpow .. endmult
end

local function getDistance(e1, e2)
	local dx = e1.position.x-e2.position.x
	local dy = e1.position.y-e2.position.y
	return math.sqrt(dx*dx+dy*dy)
end

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

function getOrCreateIndexForOrbital(entity)
	if not global.egcombat.orbital_indices[entity.unit_number] then
		--game.print("Calculating")
		local flag = false
		local entities = {}
		for _,entry in pairs(global.egcombat.orbital_indices) do
			if entry.entity.valid then
				table.insert(entities, entry.entity)
			else
				flag = true
			end
		end
		if flag then
			--game.print("Rebuilding list.")
			for i = 1,#entities do
				local val = entities[i]
				local entry2 = {index=i-1, entity=val}
				global.egcombat.orbital_indices[val.unit_number] = entry2
				--game.print("Reassigning " .. entry2.index .. " to " .. val.unit_number)
			end
		end
		--game.print("Assigning " .. #entities)
		local entry = {index=#entities, entity=entity}
		global.egcombat.orbital_indices[entity.unit_number] = entry
	end
	--game.print("Returning " .. global.egcombat.orbital_indices[entity.unit_number].index)
	return global.egcombat.orbital_indices[entity.unit_number].index
end

function scheduleOrbitalStrike(placer, inv, target)
	--inv.insert({name="orbital-manual-target", count=1})
	if not global.egcombat.scheduled_orbital then
		global.egcombat.scheduled_orbital = {}
	end
	if placer.force.get_item_launched("destroyer-satellite") > 0 and placer.force.is_chunk_charted(placer.surface, {math.floor(target.x/32), math.floor(target.y/32)}) and #placer.surface.find_entities_filtered({name="orbital-manual-target-secondary", area={{target.x-10, target.y-10},{target.x+10, target.y+10}}}) == 0 then
		local entity = placer.surface.create_entity({name="orbital-manual-target-secondary", position=target, force=placer.force})
		local loc = placer.surface.create_entity({name="orbital-manual-target-secondary", position=target, force=placer.force}) --just for location
		local fx = placer.surface.create_entity{name = "orbital-manual-target-effect", position=target}
		table.insert(global.egcombat.scheduled_orbital, {location = loc, next = entity, effect=fx, delay = 180, shots = 0})
		for _,player in pairs (game.connected_players) do
			player.add_custom_alert(entity, {type = "item", name = "orbital-manual-target"}, {"orbital-strike-incoming"}, true)
		end
		--game.print("Scheduling strike")
	else
		--target.destroy()
	end
end

function tickOrbitalStrikeSchedule()
	if global.egcombat.scheduled_orbital then
		for i=#global.egcombat.scheduled_orbital,1,-1 do
			local entry = global.egcombat.scheduled_orbital[i]
			entry.delay = entry.delay-1
			--game.print("Ticking strike @ " .. entry.location.position.x .. " , " .. entry.location.position.y .. " , tick = " .. entry.delay)
			if entry.delay == 0 then
				entry.shots = entry.shots+1
				fireOrbitalWeaponManually(entry.next)
				--game.print("Firing")
				local loc = entry.location.position
				if entry.shots < 10 and (math.random() < 0.4 or #entry.location.surface.find_entities_filtered({area = {{loc.x-24, loc.y-24}, {loc.x+24, loc.y+24}}, force=game.forces.enemy}) > 0) then
					entry.delay = math.random(5, 30)
					entry.next = entry.location.surface.create_entity({name="orbital-manual-target-secondary", position={loc.x+math.random(-10, 10), loc.y+math.random(-10, 10)}, force=entry.location.force})
				else
					table.remove(global.egcombat.scheduled_orbital, i)
					entry.location.destroy()
					entry.effect.destroy()
				end
			end
		end
	end
end

function fireOrbitalWeaponManually(target)
	local surface = target.surface
	local pos = target.position--player.selected and player.selected.position or ??
	surface.create_entity({name = "orbital-bombardment-firing-sound", position = pos, force = game.forces.neutral})
	surface.create_entity({name = "orbital-bombardment-explosion", position = pos, force = game.forces.neutral})
	surface.create_entity({name = "orbital-bombardment-crater", position = pos, force = game.forces.neutral})
	local entities = surface.find_entities_filtered({area = {{target.position.x-32, target.position.y-32}, {target.position.x+32, target.position.y+32}}})
	for _,entity in pairs(entities) do
		if entity.valid and entity.health and entity.health > 0 and game.entity_prototypes[entity.name].selectable_in_game then
			if getDistance(entity, target) <= 35 then
				if entity.type ~= "tree" and (entity.type == "player" or entity.type == "logistic-robot" or entity.type == "construction-robot" or (entity.force ~= target.force and (not target.force.get_cease_fire(entity.force)))) then
					if entity.type == "unit" or entity.type == "unit-spawner" then
						entity.surface.create_entity({name="blood-explosion-small", position=entity.position, force=entity.force})
					else
						entity.surface.create_entity({name="explosion", position=entity.position, force=entity.force})
					end
					entity.die()
				else
					entity.damage(entity.health*(0.8+math.random()*0.15), target.force, "explosion")
				end
			end
		end
	end
	target.destroy()
	for _,player in pairs (game.connected_players) do
		surface.create_entity{name = "orbital-manual-target-sound-1", position = player.position}
		surface.create_entity{name = "orbital-manual-target-sound-2", position = player.position}
	end
end

function fireOrbitalWeapon(force, entity)
	local surface = entity.surface
	local tries = 0
	local scanned = false
	while tries < 40 and not scanned do
		tries = tries+1
		local pos = {x=math.random(-40, 40), y=math.random(-40, 40)}--event.chunk_position
		pos.x = pos.x+16*math.floor(entity.position.x/32/16) --divide world into 16x16 chunk regions
		pos.y = pos.y+16*math.floor(entity.position.y/32/16)
		--game.print("Trying " .. pos.x .. "," .. pos.y .. " : " .. (force.is_chunk_charted(surface, pos) and "succeed" or "fail"))
		if force.is_chunk_charted(surface, pos) then
			scanned = true
			--destroy spawners in area, send spawn + some to attack
			--game.print(pos.x .. " , " .. pos.y)
			pos.x = pos.x*32
			pos.y = pos.y*32
			local r = 2
			local area = {{pos.x-r, pos.y-r}, {pos.x+32+r, pos.y+32+r}}
			local enemies = surface.find_entities_filtered({type = "unit-spawner", area = area, force = game.forces.enemy})
			local count = #enemies
			--game.print("Checking " .. pos.x/32 .. "," .. pos.y/32 .. " : " .. count)
			if count > 0 then
				for _,spawner in pairs(enemies) do						
					surface.create_entity({name = "orbital-bombardment-explosion", position = spawner.position, force = game.forces.neutral})
					surface.create_entity({name = "orbital-bombardment-crater", position = spawner.position, force = game.forces.neutral})
					
					spawner.die() --not destroy; use this so have destroyed spawners, drops, evo factor, NauvisDay spawns, etc
				end
				entity.energy = 0 --drain all power for a "shot"
				
				--[[
				for _,deadspawner in pairs(surface.find_entities_filtered({type = "corpse", area = area})) do
					deadspawner.
				end
				--]]
				
				surface.create_entity({name = "orbital-bombardment-firing-sound", position = entity.position, force = game.forces.neutral})
				--particles, sounds, maybe spawn some fire? (concern about forest fires)
				--[[
				surface.create_entity({name = "orbital-bombardment-crater", position = {math.random(pos.x+8, pos.x+24), math.random(pos.y+8, pos.y+24)}, force = game.forces.neutral})
				for i = 0,4 do
					surface.create_entity({name = "orbital-bombardment-explosion", position = {math.random(pos.x, pos.x+32), math.random(pos.y, pos.y+32)}, force = game.forces.neutral})
				end
				--]]
				
				--Hope your base is well defended... >:)
				local retaliation = surface.create_unit_group({position={pos.x+16, pos.y+16}, force=game.forces.enemy})
				local biters = surface.find_entities_filtered({type = "unit", area = area, force = game.forces.enemy})
				for _,biter in pairs(biters) do
					retaliation.add_member(biter)
				end
				local evo = game.forces.enemy.evolution_factor+math.random()*0.25
				local size = (1+((count-1)/2))*(10+math.ceil(15*evo))*(0.8+math.random()*0.7)
				while #retaliation.members < size do
					local biter = "small-biter"
					if evo >= 0.35 and math.random() < 0.5 then
						biter = "medium-biter"
					end
					if evo >= 0.6 and math.random() < 0.4 then
						biter = "big-biter"
					end
					if evo >= 0.9 and math.random() < 0.3 then
						biter = "behemoth-biter"
					end
					local spawn = surface.create_entity({name = biter, position = {math.random(pos.x, pos.x+32), math.random(pos.y, pos.y+32)}, force = game.forces.enemy})
					retaliation.add_member(spawn)
				end
				retaliation.set_command({type = defines.command.attack, target = entity, distraction = defines.distraction.none})
				
				surface.pollute({pos.x+16, pos.y+16}, 5000)
				local rs = 16
				force.chart(surface, {{pos.x-rs, pos.y-rs}, {pos.x+31+rs, pos.y+31+rs}})
			end
		end
	end
end

function spawnRadiationArea(entity)
	local nfire = 1600
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(2/3)*RADIATION_RADIUS
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		local lifevar = RADIATION_LIFES[math.random(1, #RADIATION_LIFES)]
		--game.print("Selecting lifevar " .. lifevar)
		local neighbors = entity.surface.find_entities_filtered({area = {{fx-2, fy-2}, {fx+2, fy+2}}, type = "fire"})
		if #neighbors <= 1 then
			entity.surface.create_entity{name = "radiation-fire-" .. lifevar, position = {x = fx, y = fy}, force = game.forces.neutral}
		end
	end
end

function spawnFireArea(entity)
	local nfire = 240+math.random(360) --was 180/160 then 240/220
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(1/2)*NAPALM_RADIUS
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		entity.surface.create_entity{name = "big-fire-flame-napalm", position = {x = fx, y = fy}, force = game.forces.neutral}
	end
end

function tickCannonTurret(entry, tick)
	if game.tick%entry.delay == 0 and (not entry.turret.get_inventory(defines.inventory.turret_ammo).is_empty()) then
		if entry.turret.shooting_target and entry.turret.shooting_target.valid and entry.turret.shooting_target.health > 0 and string.find(entry.turret.shooting_target.name, "spitter", 1, true) then
			return
		end
		--game.print("Ticking turret @ " .. entry.turret.position.x .. "," .. entry.turret.position.y)
		local scan = entry.delay >= 60
		local search = CANNON_TURRET_RANGE+getTurretRangeBoost(entry.turret.force)
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

function tickShieldDome(entry, tick)
	if entry.current_shield > 0 and not entry.rebooting then
		if tick%15 == 0 then
			--game.print("Ticking dome @ " .. entry.dome.position.x .. "," .. entry.dome.position.y)
			local enemies = entry.dome.surface.find_enemy_units(entry.dome.position, game.entity_prototypes[entry.dome.name].turret_range, entry.dome.force)
			if #enemies > 0 then
				--game.print(#enemies .. " @ " .. entry.delay))
				for _,biter in pairs(enemies) do
					if biter.valid and biter.health > 0 then
						local d = getDistance(biter, entry.dome)
						if math.abs(d-SHIELD_DOMES[entry.index].radius) <= 3 then
							if not entry.edges[biter.unit_number] or not entry.edges[biter.unit_number].entity.valid or entry.edges[biter.unit_number].entity.health <= 0 then
								local ang = math.atan2(biter.position.y-entry.dome.position.y, biter.position.x-entry.dome.position.x) --y,x, not x,y
								local pos = {x=entry.dome.position.x+SHIELD_DOMES[entry.index].radius*math.cos(ang), y=entry.dome.position.y+SHIELD_DOMES[entry.index].radius*math.sin(ang)}
								local edge = entry.dome.surface.create_entity({name="shield-dome-edge-" .. entry.index, position = pos, force=game.forces.neutral}) --neutral force so robots do not try to repair it, and does not trigger "structure damage warning"
								local fx = entry.dome.surface.create_entity({name="shield-dome-edge-effect-" .. entry.index, position = pos, force=game.forces.neutral})
								local light = entry.dome.surface.create_entity({name="shield-dome-edge-effect-light-" .. entry.index, position = pos, force=game.forces.neutral})
								--game.print("Spawning edge entity for " .. biter.name)
								local entry2 = {entity=edge, effect=fx, light=light, life=tick+150, force=entry.dome.force.name, entry_key = entry.dome.unit_number}
								entry.edges[biter.unit_number] = entry2
								global.egcombat.shield_dome_edges[biter.unit_number] = entry2
								biter.set_command({type=defines.command.attack, target=edge, distraction=defines.distraction.none})
							end
						end
					end
				end
			end
		end
		if tick%30 == 0 then
			entry.dome.surface.create_entity({name="shield-dome-effect-" .. entry.index, position = entry.dome.position, force=entry.dome.force.name})
			entry.dome.surface.create_entity({name="shield-dome-effect-light-" .. entry.index, position = entry.dome.position, force=entry.dome.force.name})
		end
		if tick%5 == 0 then --spawn some edges to show radius, and to look cool
			local num = entry.index == "small" and 1 or (entry.index == "medium" and 2 or 3)
			for i = 1,num do
				local ang = math.random()*360
				local pos = {x=entry.dome.position.x+SHIELD_DOMES[entry.index].radius*math.cos(ang), y=entry.dome.position.y+SHIELD_DOMES[entry.index].radius*math.sin(ang)}
				local edge = entry.dome.surface.create_entity({name="shield-dome-edge-" .. entry.index, position = pos, force=game.forces.neutral}) --neutral force so robots do not try to repair it, and does not trigger "structure damage warning"
				local fx = entry.dome.surface.create_entity({name="shield-dome-edge-effect-" .. entry.index, position = pos, force=game.forces.neutral})
				local light = entry.dome.surface.create_entity({name="shield-dome-edge-effect-light-" .. entry.index, position = pos, force=game.forces.neutral})
				table.insert(entry.edges, {entity=edge, effect=fx, light=light, life=tick+math.random(30, 90), force=entry.dome.force, entry_key=entry.dome.unit_number})
			end
		end
	end
	if entry.current_shield < SHIELD_DOMES[entry.index].strength then
		if entry.dome.energy >= SHIELD_DOMES[entry.index].energy_per_point*1000 then
			entry.dome.energy = entry.dome.energy-SHIELD_DOMES[entry.index].energy_per_point*1000
			entry.current_shield = entry.current_shield+1
			if entry.rebooting and entry.current_shield >= SHIELD_REACTIVATE_FRACTION*SHIELD_DOMES[entry.index].strength then
				entry.rebooting = false
				--game.print("Shields back online @ " .. entry.current_shield)
			end
		end
	end
	if entry.dome.energy == 0 then
		entry.current_shield = math.max(0, math.floor(entry.current_shield*0.95)) --lose energy if empty buffer
		--game.print("Blackout! Shield depleting!")
	end
	if #entry.edges > 0 then
		for biter,edge in pairs(entry.edges) do
			if tick >= edge.life or entry.current_shield == 0 then
				if edge.entity.valid then
					edge.entity.destroy()
				end
				if edge.effect.valid then
					edge.effect.destroy()
				end
				if edge.light and edge.light.valid then
					edge.light.destroy()
				end
				entry.edges[biter] = nil
			end
		end
	end
end

function getShieldDomeFromEdge(entity, destroy, killer)
	local edge = global.egcombat.shield_dome_edges[killer.unit_number]
	if edge then
		if global.egcombat.shield_domes[edge.force] and global.egcombat.shield_domes[edge.force][edge.entry_key] then
			local entry = global.egcombat.shield_domes[edge.force][edge.entry_key]
			if edge.entity.valid then
				if destroy then
					entry.edges[killer.unit_number] = nil
					attackShieldDome(entry, game.entity_prototypes[entity.name].max_health)
					edge.entity.destroy()
					edge.effect.destroy()
					edge.light.destroy()
				end
			else
				entry.edges[killer.unit_number] = nil --just remove, no effect
				if edge.effect and edge.effect.valid then
					edge.effect.destroy()
				end
				if edge.light and edge.light.valid then
					edge.light.destroy()
				end
			end
			return entry
		else
			error("A shield dome edge in table (killer=" .. killer.unit_number .. ") (force=" .. edge.force .. ", key=" .. edge.entry_key .. " without an entry!?")
			return nil
		end
	end
	--error("A shield dome edge (killer=" .. killer.unit_number .. ") not in table!?") happens if killed by something else, like player flamethrower
end

function getShieldDomeFromEntity(entity)
	for _,entry in pairs(global.egcombat.shield_domes[entity.force.name]) do
		if entry.dome.position.x == entity.position.x and entry.dome.position.y == entity.position.y then
			return entry
		end
	end
	error("A shield dome without an entry!?")
end

function attackShieldDome(entry, damage)
	if entry.current_shield > 0 then
		entry.current_shield = math.max(0, entry.current_shield-damage)
		--game.print("Destroying edge, subtracting " .. damage .. "health from shield. Shield health is now: " .. entry.current_shield)
		if entry.current_shield == 0 then
			entry.rebooting = true
			entry.dome.surface.create_entity({name="shield-dome-fail-effect-" .. entry.index, position = entry.dome.position, force=game.forces.neutral})
			entry.dome.surface.create_entity({name="shield-dome-fail-effect-light-" .. entry.index, position = entry.dome.position, force=entry.dome.force.name})
			--game.print("Shield offline. Rebooting.")
		end
	end
end

function tickShockwaveTurret(entry, tick)
	if game.tick%entry.delay == 0 and entry.turret.energy >= SHOCKWAVE_TURRET_DISCHARGE_ENERGY then
		--game.print("Ticking turret @ " .. entry.turret.position.x .. "," .. entry.turret.position.y)
		local scan = entry.delay >= 40
		local enemies = entry.turret.surface.find_enemy_units(entry.turret.position, (scan and SHOCKWAVE_TURRET_SCAN_RADIUS or SHOCKWAVE_TURRET_RADIUS)+math.floor(getTurretRangeBoost(entry.turret.force)/2), entry.turret.force)
		if #enemies > 0 then
			local flag = false
			local f = getShockwaveTurretDamageFactor(entry.turret.force)
			--game.print(#enemies .. " @ " .. entry.delay .. " > " .. (scan and "true" or "false"))
			for _,biter in pairs(enemies) do
				if biter.valid then
					local d = getDistance(biter, entry.turret)
					if ((not scan) or d <= SHOCKWAVE_TURRET_RADIUS) then
						local cap = math.max(10, 50*math.min(1, 1-math.ceil((d-5)/5)))
						flag = true
						entry.turret.surface.create_entity({name="blood-explosion-small", position=biter.position, force=biter.force})
						entry.turret.surface.create_entity({name="shockwave-beam", position=entry.turret.position, force=entry.turret.force, target=biter, source=entry.turret})
						--game.print("Attacking biter @ " .. biter.position.x .. "," .. biter.position.y)
						local maxh = game.entity_prototypes[biter.name].max_health
						local dmg = maxh < 20 and 4*(1+(f-1)*1.5) or math.min(cap*(1+(f-1)*2), math.max(3, math.min(maxh/2, maxh*f/10)))
						biter.damage(dmg, entry.turret.force, "electric")
						entry.turret.damage_dealt = entry.turret.damage_dealt+dmg
						if not biter.valid or biter.health <= 0 then
							entry.turret.kills = entry.turret.kills+1
						end
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

function getTurretRangeBoost(force)
	local level = getTurretRangeResearch(force)
	return level > 0 and TURRET_RANGE_BOOST_SUMS[level] or 0
end

function getTurretRangeResearch(force)
	if not force.technologies["turret-range-1"].researched then return 0 end
	local level = 1
	for i = #TURRET_RANGE_BOOSTS, 1, -1 do
		if force.technologies["turret-range-" .. i].researched then
			level = i
			break
		end
	end
	return level
end

function getTurretBaseNameByName(name, level)
	if string.find(name, "-rangeboost-", 1, true) then
		local n = level == 10 and 3 or 2
		name = string.sub(name, 1, -string.len("-rangeboost-")-n) --aka Java substring(0, length()-"-rangeboost-".length()-n)
	end
	return name
end

function getTurretBaseName(turret)
	return getTurretBaseNameByName(turret.name, getTurretRangeResearch(turret.force))
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

local function replaceTurretKeepingContents(turret, newname)
	local surf = turret.surface
	local pos = {turret.position.x, turret.position.y}
	local dir = turret.direction
	local h = turret.health
	local f = turret.force
	local e = turret.energy
	local dmg = turret.damage_dealt
	local kills = turret.kills
	local inv = turret.get_inventory(defines.inventory.turret_ammo)
	local items = nil
	if inv ~= nil then
		items = {}
		for i = 1,#inv do
			local stack = inv[i]
			if stack and stack.valid_for_read then
				items[#items+1] = {item = stack.name, num = stack.count}
			else
				items[#items+1] = nil
			end
		end
	end
	local fluids = nil
	local fbox = turret.fluidbox
	if fbox ~= nil then
		fluids = {}
		for i = 1,#fbox do
			local stack = fbox[i]
			if stack then
				fluids[#fluids+1] = {fluid = stack.type, amount = stack.amount, temp = stack.temperature}
			else
				fluids[#fluids+1] = nil
			end
		end
	end
	turret.destroy()
	local repl = surf.create_entity{name=newname, position=pos, direction=dir, force=f, fast_replace=true, spill=false}
	repl.energy = e
	repl.kills = kills
	repl.damage_dealt = dmg
	repl.health = h
	if items ~= nil then
		for i = 1,#items do
			local stack = items[i]
			if stack ~= nil then
				repl.insert({name = stack.item, count = stack.num})
			end
		end
	end
	if fluids ~= nil then
		for i = 1,#fluids do
			local stack = fluids[i]
			if stack ~= nil then
				repl.fluidbox[i] = {type = stack.fluid, amount = stack.amount, temperature = stack.temp}
			end
		end
	end
	if repl.health == 0 then --fixes a "replacement on death with base turret" bug
		repl.die()
	end
	return repl
end

function convertTurretForRange(turret, level)
	if level == 0 then return turret end
	if not turret.valid then return turret end
	if not turret.surface.valid then return turret end
	local n = getTurretBaseName(turret) .. "-rangeboost-" .. level
	return game.entity_prototypes[n] and replaceTurretKeepingContents(turret, n) or turret --if does not have a counterpart (technical entity), just return the original
end

function convertTurretForRangeWhileKeepingSpecialCaches(turret, level)
	local ret = convertTurretForRange(turret, level)
	local force = ret.force.name
	checkAndCacheTurret(ret, force)
end

function checkAndCacheTurret(turret, force)
	if string.find(turret.name, "shockwave-turret", 1, true) then
		if global.egcombat.shockwave_turrets[force] == nil then
			global.egcombat.shockwave_turrets[force] = {}
		end
		table.insert(global.egcombat.shockwave_turrets[force], {turret=turret, delay=60})
		--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "cannon-turret", 1, true) then
		if global.egcombat.cannon_turrets[force] == nil then
			global.egcombat.cannon_turrets[force] = {}
		end
		table.insert(global.egcombat.cannon_turrets[force], {turret=turret, delay=90})
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "shield-dome", 1, true) then
		if global.egcombat.shield_domes[force] == nil then
			global.egcombat.shield_domes[force] = {}
		end
		local idx = string.sub(turret.name, 1, -string.len("shield-dome")-2) --is the name
		global.egcombat.shield_domes[force][turret.unit_number] = {dome=turret, index = idx, current_shield = 0, edges = {}}
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
end

function deconvertTurretForRange(turret)
	if not turret.valid then return turret end
	if not turret.surface.valid then return turret end
	if string.find(turret.name, "-rangeboost-", 1, true) then
		local n = getTurretBaseName(turret)
		return replaceTurretKeepingContents(turret, n)
	end
	return turret
end