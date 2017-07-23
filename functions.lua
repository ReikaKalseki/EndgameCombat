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

function getTurretBaseName(turret)
	local basename = turret.name
	if string.find(basename, "-rangeboost-") then
		basename = string.sub(turret.name, 1, -string.len("-rangeboost-")-2) --aka Java substring(0, length()-"-rangeboost-".length()-1)
	end
	return basename
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
	return repl
end

function convertTurretForRange(turret, level)
	if level == 0 then return turret end
	if not turret.valid then return turret end
	if not turret.surface.valid then return turret end
	local n = getTurretBaseName(turret) .. "-rangeboost-" .. level
	return replaceTurretKeepingContents(turret, n)
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