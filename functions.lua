require "constants"
require "plasmabeam"

function createCapsuleDamage(capsule, name, dtype)
	if type(capsule) == "string" then capsule = data.raw["smoke-with-trigger"][capsule] end
	local dat = CLOUD_DAMAGE_PROFILES[name]
	local base = data.raw["smoke-with-trigger"]["poison-cloud"]
	local action = table.deepcopy(base.action)
    action.action_delivery.target_effects.action.radius = action.action_delivery.target_effects.action.radius*dat.radius
	local newdmg = action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount
	newdmg = newdmg*dat.dps*dat.tickrate
    action.action_delivery.target_effects.action.action_delivery.target_effects.damage = {amount = newdmg, type = dtype}
	table.insert(action.action_delivery.target_effects.action.entity_flags, "placeable-enemy")
	capsule.action = action
	capsule.action_cooldown = base.action_cooldown*dat.tickrate
	capsule.duration = base.duration*dat.total/dat.dps
	capsule.animation.scale = base.animation.scale*dat.radius
end

function createTotalResistance()
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

function changeAmmoDamage(ammo, damages)
	local effects = data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects
	local repl = {}
	for _,effect in pairs(effects) do
		if effect.type ~= "damage" then
			table.insert(repl, effect)
		end
	end
	data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects = repl
	for i = 1,#damages,2 do
		local type_ = damages[i]
		local amt = damages[i+1]
		table.insert(data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects, {type = "damage", damage = {amount = amt, type = type_}})
	end
end

local function getRetaliationLevel(force, type)
	local name = type .. "-retaliation-"
	local ret = 0
	for lvl,val in pairs(RETALIATIONS[type]) do
		local name2 = name .. lvl
		if force.technologies[name2].researched then
			ret = math.max(ret, lvl)
		end
	end
	return ret
end

function doRetaliation(attacker, raw, target, type)
	local force = target.force
	if attacker.force == force then return end--friendly fire
	local lvl = getRetaliationLevel(force, type)
	if lvl <= 0 then return end
	local amt = RETALIATIONS[type][lvl].func(raw, attacker.prototype.max_health)
	--game.print("Found level " .. lvl .. " for type " .. type .. ": " .. raw .. " > " .. amt)
	attacker.surface.create_entity{name = "shockwave-beam", position = target.position, source = target, target = attacker, force = force}
	for _,player in pairs(game.players) do
		player.play_sound{path="shockwave-sound", position=attacker.position, volume_modifier=1}
	end
	attacker.damage(amt, force, "electric")
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

function cleanTissueNearPlayer(egcombat, player)
	local r = 32
	local drops = player.surface.find_entities_filtered{area={{player.position.x-r, player.position.y-r}, {player.position.x+r, player.position.y+r}}, type="item-entity"}
	for _,item in pairs(drops) do
		if item.stack and item.stack.valid_for_read and item.stack.name == "biter-flesh" and not (item.to_be_deconstructed(game.forces.player)) then
			table.insert(egcombat.fleshToDeconstruct, {entity=item, time=game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
			--item.order_deconstruction(game.forces.player)
		end
	end
end

function doTissueDrops(egcombat, entity)
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
		range = 0.75
	end
	--game.print("Attempting " .. drops .. " drops.")
	if drops > 0 then
		for i = 1,drops do
			local pos = {x = entity.position.x, y = entity.position.y}
			pos.x = pos.x-range+math.random()*2*range
			pos.y = pos.y-range+math.random()*2*range
			local r = 0.25--1
			local box = {{pos.x-r,pos.y-r},{pos.x+r,pos.y+r}}
			local belts = entity.surface.find_entities_filtered{area=box, type={"transport-belt", "underground-belt", "loader", "item-entity"}, limit = 1}
			if belts and #belts > 0 then --do not spill items on belts, or on top of each other
				drops = math.min(drops+1, 20) --add a retry, within a limit
				--game.print("Failed drop " .. i .. ", trying again...")
			else
				--game.print("Dropping drop @ " .. pos.x .. ", " .. pos.y)
				entity.surface.spill_item_stack(pos, {name="biter-flesh"}, true) --does not return
				if Config.deconstructFlesh then --mark for deconstruction? Will draw robots into attack waves and turret fire... -> make config
					local drops = entity.surface.find_entities_filtered{area=box--[[position = pos--]], type="item-entity"}
					for _,item in pairs(drops) do
						if item.stack and item.stack.valid_for_read and item.stack.name == "biter-flesh" then
							table.insert(egcombat.fleshToDeconstruct, {entity=item, time=game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
							--item.order_deconstruction(game.forces.player)
						end
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

function isTableAnArray(t)
	--are all indices numerical; count for later
	local count = 0
	for k,v in pairs(t) do
		if type(k) ~= "number" then
			return false
		else
			count = count+1
		end
	end
	
	--check if indices are 1->N in order
	for i = 1,count do
		if (not t[i]) and type(t[i]) ~= "nil" then --The value might be nil, have to check the type too
			return false
		end
	end
	return true
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

function spawnCapsuleFireArea(entity)
	local nfire = math.random(1, 5)
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(1/2)*4
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		entity.surface.create_entity{name = "big-fire-flame-napalm", position = {x = fx, y = fy}, force = game.forces.neutral}
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
		if not entry then game.print("Dome with no entry @ " .. entity.position.x .. ", " .. entity.position.y .. " ?") return end
		for biter,edge in pairs(entry.edges) do
			edge.entity.destroy()
			if edge.effect and edge.effect.valid then
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

function removeLightningTurret(egcombat, entity)
	if string.find(entity.name, "lightning-turret", 1, true) and egcombat.lightning_turrets[entity.force.name] then
		egcombat.lightning_turrets[entity.force.name][entity.unit_number] = nil
	end
end

function checkAndCacheTurret(egcombat, turret, force)
	if string.find(turret.name, "shockwave-turret", 1, true) then
		if egcombat.shockwave_turrets[force.name] == nil then
			egcombat.shockwave_turrets[force.name] = {}
		end
		table.insert(egcombat.shockwave_turrets[force.name], {turret=turret, delay=60})
		--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "cannon-turret", 1, true) then
		if egcombat.cannon_turrets[force.name] == nil then
			egcombat.cannon_turrets[force.name] = {}
		end
		table.insert(egcombat.cannon_turrets[force.name], {turret=turret, delay=90})
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "lightning-turret", 1, true) then
		if egcombat.lightning_turrets[force.name] == nil then
			egcombat.lightning_turrets[force.name] = {}
		end
		egcombat.lightning_turrets[force.name][turret.unit_number] = {turret=turret, delay=90}
		rechargeLightningTurret(egcombat, turret)
		--game.print("Lightning turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "shield-dome", 1, true) then
		if egcombat.shield_domes[force.name] == nil then
			egcombat.shield_domes[force.name] = {}
		end
		local idx = string.sub(turret.name, 1, -string.len("shield-dome")-2) --is the name
		local conn = turret.surface.create_entity({name="dome-circuit-connection", position = {turret.position.x+0.75, turret.position.y+0.75}, force=force})
		conn.operable = false
		egcombat.shield_domes[force.name][turret.unit_number] = {dome=turret, circuit = conn, delay = 60, index = idx, current_shield = 0, strength_factor = getCurrentDomeStrengthFactor(force), cost_factor = getCurrentDomeCostFactor(force), edges = {}}
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
end

function isTechnicalTurret(name)
	if name == "AlienControlStation_Area" then
		return true
	end
	return false
end

function createLogisticInterface(turret)
	if isTechnicalTurret(turret.name) then return false end --technical entity
	local force = turret.force
	if (turret.type == "ammo-turret" or turret.type == "artillery-turret") and force.technologies["turret-logistics"].researched and #turret.get_inventory(defines.inventory.turret_ammo) > 0 then
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