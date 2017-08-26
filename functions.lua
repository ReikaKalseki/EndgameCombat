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

function createTotalResistance()
--[[
	resistances = {
	  {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 100
      },
	  {
        type = "acid",
        percent = 100
      },
	  {
        type = "impact",
        percent = 100
      },
	  {
        type = "piercing",
        percent = 100
      },
	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "explosion",
        percent = 100
      },
	  {
        type = "poison",
        percent = 100
      },
	}
	--]]
	local ret = {}
	for name,damage in pairs(data.raw["damage-type"]) do
		table.insert(ret, {type = name, percent = 100})
	end
	return ret
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
		if v.type == type_ then --if resistance to that type already present, overwrite-with-max rather than have two for same type
			v.decrease = math.max(v.decrease, reduce)
			v.percent = math.max(v.percent, percent)
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
	local obj = data.raw.locomotive[train]
	local pow = obj.max_power
	local num = string.sub(pow, 1, -3)
	local endmult = string.sub(pow, -2, -1)
	local newpow = num*factor
	obj.max_power = newpow .. endmult
end

local function roundToGridBitShift(position, shift)
	position.x = bit32.lshift(bit32.rshift(position.x, shift), shift)
	position.y = bit32.lshift(bit32.rshift(position.y, shift), shift)
	return position
end

function getPositionForBPEntity(entity)
	local position = entity.position
	
	if (entity.has_flag("placeable-off-grid")) then
		return position
	end

	local buildingGridBitShift = entity.building_grid_bit_shift
	local tiledResult = position
	tiledResult = roundToGridBitShift(tiledResult, buildingGridBitShift)
	local result = {x=tiledResult.x, y=tiledResult.y}
	result.x = result.x + bit32.lshift(1, buildingGridBitShift) * 0.5
	result.y = result.y + bit32.lshift(1, buildingGridBitShift) * 0.5
	return result
end

function doTissueDrops(entity)
	local drops = 0
	local range = 0
	if entity.type == "unit-spawner" and (string.find(entity.name, "biter") or string.find(entity.name, "spitter")) then
		drops = math.random(5, 12)
		range = 4
	end
	if entity.type == "worm-turret" and string.find(entity.name, "worm") then
		drops = math.random(2, 5)
		range = 2
	end
	if entity.type == "unit" and Config.bitersDropFlesh and (string.find(entity.name, "biter") or string.find(entity.name, "spitter")) then
		local size = 0
		if string.find(entity.name, "small") then
			size = 0.1
		end
		if string.find(entity.name, "medium") then
			size = 0.25
		end
		if string.find(entity.name, "big") then
			size = 0.5
		end
		if string.find(entity.name, "behemoth") then
			size = 1
		end
		drops = math.random() < size and (math.random() < 0.2 and math.random(1, 2) or math.random(0, 1)) or 0
		range = 1
	end
	if drops > 0 then
		for i = 1,drops do
			local pos = {entity.position.x, entity.position.y}
			pos[1] = pos[1]-range+math.random()*2*range
			pos[2] = pos[2]-range+math.random()*2*range
			entity.surface.spill_item_stack(pos, {name="biter-flesh"}, true) --does not return
			if Config.deconstructFlesh then --mark for deconstruction? Will draw robots into attack waves and turret fire... -> make config
				local drops = entity.surface.find_entities_filtered{area={{pos[1]-1,pos[2]-1},{pos[1]+1,pos[2]+1}}--[[position = pos--]], type="item-entity"}
				for _,item in pairs(drops) do
					if item.stack and item.stack.name == "biter-flesh" then
						table.insert(global.egcombat.fleshToDeconstruct, {item, game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
						--item.order_deconstruction(game.forces.player)
					end
				end
			end
		end
	end
end

function getDistance(e1, e2)
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
				if biter.valid and biter.health > 0 then
					local d = getDistance(biter, entry.turret)
					if ((not scan) or d <= SHOCKWAVE_TURRET_RADIUS) then
						local cap = math.max(10, 50*math.min(1, 1-math.ceil((d-5)/5)))
						flag = true
						entry.turret.surface.create_entity({name="shockwave-beam", position=entry.turret.position, force=entry.turret.force, target=biter, source=entry.turret})
						--game.print("Attacking biter @ " .. biter.position.x .. "," .. biter.position.y)
						local maxh = game.entity_prototypes[biter.name].max_health
						local dmg = maxh < 20 and 4*(1+(f-1)*1.5) or math.min(cap*(1+(f-1)*2), math.max(3, math.min(maxh/2, maxh*f/10)))
						biter.damage(dmg, entry.turret.force, "electric")
						if scan or game.tick%(6*entry.delay) == 0 or (not biter.valid) or biter.health <= 0 then
							entry.turret.surface.create_entity({name="blood-explosion-small", position=biter.position, force=biter.force})
						end
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

function removeShockwaveTurret(egcombat, entity)
	if string.find(entity.name, "shockwave-turret", 1, true) and egcombat.shockwave_turrets[entity.force.name] then
		for i, entry in ipairs(egcombat.shockwave_turrets[entity.force.name]) do
			if entry.turret.position.x == entity.position.x and entry.turret.position.y == entity.position.y then
				table.remove(egcombat.shockwave_turrets[entity.force.name], i)
				break
			end
		end
	end
end

function removeCannonTurret(egcombat, entity)
	if string.find(entity.name, "cannon-turret", 1, true) and egcombat.cannon_turrets[entity.force.name] then
		for i, entry in ipairs(egcombat.cannon_turrets[entity.force.name]) do
			if entry.turret.position.x == entity.position.x and entry.turret.position.y == entity.position.y then
				table.remove(egcombat.cannon_turrets[entity.force.name], i)
				break
			end
		end
	end
end

function removeShieldDome(egcombat, entity)
	if string.find(entity.name, "shield-dome", 1, true) and egcombat.shield_domes[entity.force.name] then
		local entry = egcombat.shield_domes[entity.force.name][entity.unit_number]
		for biter,edge in pairs(entry.edges) do
			edge.entity.destroy()
			if edge.effect.valid then
				edge.effect.destroy()
			end
			if edge.light and edge.light.valid then
				edge.light.destroy()
			end
		end
		if entry.circuit then
			entry.circuit.disconnect_neighbour(defines.wire_type.red)
			entry.circuit.disconnect_neighbour(defines.wire_type.green)
			entry.circuit.destroy()
		end
		egcombat.shield_domes[entity.force.name][entity.unit_number] = nil
	end
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

function getTurretBaseNameByName(name)
	if string.find(name, "-rangeboost-", 1, true) then
		local n = string.find(name, "rangeboost-10", 1, true) and 3 or 2
		name = string.sub(name, 1, -string.len("-rangeboost-")-n) --aka Java substring(0, length()-"-rangeboost-".length()-n)
	end
	return name
end

function getTurretBaseName(turret)
	return getTurretBaseNameByName(turret.name)
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
	local force = ret.force
	checkAndCacheTurret(ret, force)
end

function checkAndCacheTurret(turret, force)
	if string.find(turret.name, "shockwave-turret", 1, true) then
		if global.egcombat.shockwave_turrets[force.name] == nil then
			global.egcombat.shockwave_turrets[force.name] = {}
		end
		table.insert(global.egcombat.shockwave_turrets[force.name], {turret=turret, delay=60})
		--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "cannon-turret", 1, true) then
		if global.egcombat.cannon_turrets[force.name] == nil then
			global.egcombat.cannon_turrets[force.name] = {}
		end
		table.insert(global.egcombat.cannon_turrets[force.name], {turret=turret, delay=90})
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "shield-dome", 1, true) then
		if global.egcombat.shield_domes[force.name] == nil then
			global.egcombat.shield_domes[force.name] = {}
		end
		local idx = string.sub(turret.name, 1, -string.len("shield-dome")-2) --is the name
		local conn = turret.surface.create_entity({name="dome-circuit-connection", position = {turret.position.x+0.75, turret.position.y+0.75}, force=force})
		conn.operable = false
		global.egcombat.shield_domes[force.name][turret.unit_number] = {dome=turret, circuit = conn, delay = 60, index = idx, current_shield = 0, strength_factor = getCurrentDomeStrengthFactor(force), cost_factor = getCurrentDomeCostFactor(force), edges = {}}
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

function createLogisticInterface(turret)
	local force = turret.force
	if turret.type == "ammo-turret" and force.technologies["turret-logistics"].researched and #turret.get_inventory(defines.inventory.turret_ammo) > 0 then
		local pos = turret.position
		local surface = turret.surface
		local logi = surface.create_entity({name="turret-logistic-interface", position={pos.x+0.5, pos.y+0.5}, force=force})
		return logi
	end
	return nil
end

function createTurretEntry(turret)
	if not turret.valid then return nil end
	local ret = {type = turret.type, turret=turret, logistic=createLogisticInterface(turret)}
	return ret
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
					entry.logistic.set_request_slot({name=inv[1].name, count=math.min(100, math.max(5, math.ceil(inv[1].prototype.stack_size/2)))}, 1)
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