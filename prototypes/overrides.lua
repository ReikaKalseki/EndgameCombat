require("functions")
require "constants"

require "__DragonIndustries__.entities"

require "prototypes.artillery-overrides"

data.raw["ammo-turret"]["gun-turret"].fast_replaceable_group = "gun-turret"
data.raw["electric-turret"]["laser-turret"].fast_replaceable_group = "laser-turret"
data.raw["radar"]["radar"].fast_replaceable_group = "radar"

if data.raw["radar"]["radarmk2"] then
	data.raw["radar"]["radarmk2"].fast_replaceable_group = "radar"
end

if data.raw["radar"]["radarmk3"] then
	data.raw["radar"]["radarmk3"].fast_replaceable_group = "radar"
end

--[[
table.insert(data.raw["unit-spawner"]["biter-spawner"].flags,"animal")
table.insert(data.raw["unit-spawner"]["spitter-spawner"].flags,"animal")
table.insert(data.raw["unit"]["small-biter"].flags,"animal")
table.insert(data.raw["unit"]["medium-biter"].flags,"animal")
table.insert(data.raw["unit"]["big-biter"].flags,"animal")
table.insert(data.raw["unit"]["behemoth-biter"].flags,"animal")
table.insert(data.raw["unit"]["small-spitter"].flags,"animal")
table.insert(data.raw["unit"]["medium-spitter"].flags,"animal")
table.insert(data.raw["unit"]["big-spitter"].flags,"animal")
table.insert(data.raw["unit"]["behemoth-spitter"].flags,"animal")
table.insert(data.raw["player"]["player"].flags,"animal")
--]]

--addCategoryResistance("turret", "radiation", 0, 100) --worms, do not make resistant
addCategoryResistance("ammo-turret", "radiation", 0, 100)
addCategoryResistance("electric-turret", "radiation", 0, 100)
addCategoryResistance("fluid-turret", "radiation", 0, 100)
addCategoryResistance("wall", "radiation", 0, 100)
addCategoryResistance("gate", "radiation", 0, 100)

addCategoryResistance("cliff", "radiation", 0, 100)
addCategoryResistance("simple-entity", "radiation", 0, 100)

addCategoryResistance("logistic-robot", "radiation", 0, 100)
addCategoryResistance("construction-robot", "radiation", 0, 100)
addCategoryResistance("car", "radiation", 0, 100) --also includes tank
addCategoryResistance("locomotive", "radiation", 0, 100)
addCategoryResistance("cargo-wagon", "radiation", 0, 100)
addCategoryResistance("fluid-wagon", "radiation", 0, 100)

addCategoryResistance("assembling-machine", "radiation", 0, 100)
addCategoryResistance("electric-pole", "radiation", 0, 100)
addCategoryResistance("straight-rail", "radiation", 0, 100)
addCategoryResistance("curved-rail", "radiation", 0, 100)
addCategoryResistance("pipe", "radiation", 0, 100)
addCategoryResistance("pipe-to-ground", "radiation", 0, 100)
addCategoryResistance("transport-belt", "radiation", 0, 100)
addCategoryResistance("underground-belt", "radiation", 0, 100)
addCategoryResistance("splitter", "radiation", 0, 100)
addCategoryResistance("inserter", "radiation", 0, 100)
addCategoryResistance("container", "radiation", 0, 100)
addCategoryResistance("logistic-container", "radiation", 0, 100)
addCategoryResistance("mining-drill", "radiation", 0, 100)
addCategoryResistance("lamp", "radiation", 0, 100)
addCategoryResistance("storage-tank", "radiation", 0, 100)

addCategoryResistance("constant-combinator", "radiation", 0, 100)
addCategoryResistance("decider-combinator", "radiation", 0, 100)
addCategoryResistance("arithmetic-combinator", "radiation", 0, 100)

for _,cat in pairs(entityCategories) do
	for name,proto in pairs(data.raw[cat]) do
		local resist = proto.resistances
		if resist and #resist > 0 then
			for _,e in pairs(resist) do
				if e.type == "fire" and e.percent == 100 then
					log("Entity type '" .. name .. "' fireproofing copied over to napalm.")
					addResistance(cat, name, "napalm", e.decrease, e.percent)
				end
			end
		end
	end
end

--increase train weights (for more penetrative power in collisions; requires also increasing torque/braking and compensating fuel efficiency to match)
for name,proto in pairs(data.raw.locomotive) do
	local tier = getObjectTier(proto)
	if not tier then tier = 1 end
	local f = math.pow(1.6, tier-1)
	local f2 = HEAVY_TRAIN_FACTOR*f
	proto.energy_per_hit_point = proto.energy_per_hit_point/f2
	proto.weight = proto.weight*f2
	proto.braking_force = proto.braking_force and proto.braking_force*f2
	proto.braking_power = proto.braking_power and proto.braking_power*f2
	--proto.max_power = proto.max_power*f2
	if proto.burner then
		proto.burner.effectivity = proto.burner.effectivity*f2
	end
	Modify_Power(proto, f2)
	addResistance("locomotive", name, "impact", 400, 99)
	log("Increasing train " .. name .. " (detected as tier " .. tier .. ") impact power " .. f2 .. " times.") 
end

for name,proto in pairs(data.raw["cargo-wagon"]) do
	addResistance("cargo-wagon", name, "impact", 400, 98)
end

for name,proto in pairs(data.raw["fluid-wagon"]) do
	addResistance("fluid-wagon", name, "impact", 400, 98)
end

if mods["bobwarfare"] then
	changeAmmoDamage("sulfur-bullet-magazine", {"physical", 5, "bob-pierce", 1, "fire", 5})
	changeAmmoDamage("sulfur-heavy-bullet-magazine", {"physical", 18, "bob-pierce", 4, "fire", 9})
else
	changeAmmoDamage("piercing-rounds-magazine", {"physical", 7, "piercing", 2}) --increase damage to make it cost-effective
	changeAmmoDamage("uranium-rounds-magazine", {"physical", 20, "piercing", 6})
	changeAmmoDamage("sulfur-bullet-magazine", {"physical", 5, "piercing", 1, "fire", 5})
	changeAmmoDamage("sulfur-heavy-bullet-magazine", {"physical", 18, "piercing", 4, "fire", 9})
	
	data:extend({{type = "damage-type", name = "piercing"}})
end

for i = 1,10 do
	local tech = data.raw.technology["laser-damage-" .. i]
	if tech then
		for _,effect in pairs(tech.effects) do
			effect.modifier = i/10
		end
		--table.insert(tech.effects, { type = "ammo-damage", ammo_category = "plasma-turret", modifier = i/10 })
	end
end

if data.raw.fluid["nitric-acid"] then
	table.insert(data.raw["fluid-turret"]["acid-turret"].attack_parameters.fluids, {type = "nitric-acid", damage_modifier = 1.25})
end
if data.raw.fluid["hydrochloric-acid"] then
	table.insert(data.raw["fluid-turret"]["acid-turret"].attack_parameters.fluids, {type = "hydrochloric-acid", damage_modifier = 1.125})
end
if data.raw.fluid["hydrogen-chloride"] then
	table.insert(data.raw["fluid-turret"]["acid-turret"].attack_parameters.fluids, {type = "hydrogen-chloride", damage_modifier = 1.125})
end

table.insert(data.raw["lab"]["lab"].inputs,"biter-flesh")

table.insert(data.raw.technology["military-3"].effects, {type = "unlock-recipe", recipe = "supercavitating-bullet-magazine"})

for cat,values in pairs(TURRET_HEALTH_PRIORITY) do
	for name,val in pairs(values) do
		log("Adding health priority " .. val .. " to turret " .. name)
		data.raw["electric-turret"]["laser-turret"].attack_parameters.health_penalty = -val
	end
end

if data.raw.car["heli-entity-_-"] then
	for name,car in pairs(data.raw.car) do
		if string.find(name, "heli", 1, true) then
			--error(serpent.block(car.consumption .. " >> " .. string.sub(car.consumption, 1, -3) .. " >>> " .. tonumber(string.sub(car.consumption, 1, -3))))
			if car.guns and #car.guns > 0 then --skip technical entities
				table.insert(car.guns, "flamethrower-2")
			end
		end
	end
end
