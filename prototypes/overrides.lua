require("functions")
require "constants"

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

addCategoryResistance("logistic-robot", "radiation", 0, 100)
addCategoryResistance("construction-robot", "radiation", 0, 100)
addCategoryResistance("car", "radiation", 0, 100) --also includes tank
addCategoryResistance("locomotive", "radiation", 0, 100)

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
	
if data.raw["construction-robot"]["bob-construction-robot-2"] then
	data.raw["construction-robot"]["construction-robot"].attack_reaction = Robot_Defence(0.4)
	data.raw["construction-robot"]["bob-construction-robot-2"].attack_reaction = Robot_Defence(0.6)
	data.raw["construction-robot"]["bob-construction-robot-3"].attack_reaction = Robot_Defence(1)
	data.raw["construction-robot"]["bob-construction-robot-4"].attack_reaction = Robot_Defence(2)
else
	data.raw["construction-robot"]["construction-robot"].attack_reaction = Robot_Defence(1)
end
if data.raw["logistic-robot"]["bob-logistic-robot-2"] then
	data.raw["logistic-robot"]["logistic-robot"].attack_reaction = Robot_Defence(0.4)
	data.raw["logistic-robot"]["bob-logistic-robot-2"].attack_reaction = Robot_Defence(0.6)
	data.raw["logistic-robot"]["bob-logistic-robot-3"].attack_reaction = Robot_Defence(1)
	data.raw["logistic-robot"]["bob-logistic-robot-4"].attack_reaction = Robot_Defence(2)
else
	data.raw["logistic-robot"]["logistic-robot"].attack_reaction = Robot_Defence(1)
end

if data.raw["electric-pole"]["big-electric-pole-2"] then
	data.raw["electric-pole"]["big-electric-pole"].attack_reaction = Electric_Pole_Defence(0.4)
	data.raw["electric-pole"]["big-electric-pole-2"].attack_reaction = Electric_Pole_Defence(0.6)
	data.raw["electric-pole"]["big-electric-pole-3"].attack_reaction = Electric_Pole_Defence(1)
	data.raw["electric-pole"]["big-electric-pole-4"].attack_reaction = Electric_Pole_Defence(2)
else
	data.raw["electric-pole"]["big-electric-pole"].attack_reaction = Electric_Pole_Defence(1)
end

for k,radar in pairs(data.raw["radar"]) do
	radar.attack_reaction = Radar_Defence(1)
end


--increase train weights (for more penetrative power in collisions; requires also increasing torque/braking and compensating fuel efficiency to match)
data.raw["locomotive"]["locomotive"].weight = data.raw["locomotive"]["locomotive"].weight*HEAVY_TRAIN_FACTOR --was 2000
data.raw["locomotive"]["locomotive"].braking_force = data.raw["locomotive"]["locomotive"].braking_force*HEAVY_TRAIN_FACTOR
--data.raw["locomotive"]["locomotive"].max_power = data.raw["locomotive"]["locomotive"].max_power*HEAVY_TRAIN_FACTOR
Modify_Power("locomotive", HEAVY_TRAIN_FACTOR)
data.raw["locomotive"]["locomotive"].burner.effectivity = data.raw["locomotive"]["locomotive"].burner.effectivity*HEAVY_TRAIN_FACTOR
addResistance("locomotive", "locomotive", "impact", 400, 99)
addResistance("cargo-wagon", "cargo-wagon", "impact", 400, 98)
if data.raw["locomotive"]["locomotive-2"] then
	data.raw["locomotive"]["locomotive-2"].weight = data.raw["locomotive"]["locomotive-2"].weight*HEAVY_TRAIN_FACTOR*1.6 --was 2000
	data.raw["locomotive"]["locomotive-2"].braking_force = data.raw["locomotive"]["locomotive-2"].braking_force*HEAVY_TRAIN_FACTOR*1.6
	--data.raw["locomotive"]["locomotive-2"].max_power = data.raw["locomotive"]["locomotive-2"].max_power*HEAVY_TRAIN_FACTOR*1.6
	Modify_Power("locomotive-2", HEAVY_TRAIN_FACTOR*1.6)
	data.raw["locomotive"]["locomotive-2"].burner.effectivity = data.raw["locomotive"]["locomotive-2"].burner.effectivity*HEAVY_TRAIN_FACTOR*1.6
	addResistance("locomotive", "locomotive-2", "impact", 400, 99)
	addResistance("cargo-wagon", "cargo-wagon-2", "impact", 400, 98)

	data.raw["locomotive"]["locomotive-3"].weight = data.raw["locomotive"]["locomotive-3"].weight*HEAVY_TRAIN_FACTOR*2.4 --was 2000
	data.raw["locomotive"]["locomotive-3"].braking_force = data.raw["locomotive"]["locomotive-3"].braking_force*HEAVY_TRAIN_FACTOR*2.4
	--data.raw["locomotive"]["locomotive-3"].max_power = data.raw["locomotive"]["locomotive-3"].max_power*HEAVY_TRAIN_FACTOR*2.4
	Modify_Power("locomotive-3", HEAVY_TRAIN_FACTOR*2.4)
	data.raw["locomotive"]["locomotive-3"].burner.effectivity = data.raw["locomotive"]["locomotive-3"].burner.effectivity*HEAVY_TRAIN_FACTOR*2.4
	addResistance("locomotive", "locomotive-3", "impact", 400, 99)
	addResistance("cargo-wagon", "cargo-wagon-3", "impact", 400, 98)
end

if data.raw["beam"] and data.raw["beam"]["laser-beam-red"] then
	data:extend({
		createPlasmaBeam()
	})  
	data.raw["electric-turret"]["plasma-turret"].attack_parameters = createPlasmaAttack()
end

table.insert(data.raw["lab"]["lab"].inputs,"biter-flesh")