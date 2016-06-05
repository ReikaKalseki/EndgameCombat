require("functions")

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
addCategoryResistance("electric-pole", "radiation", 0, 100)
addCategoryResistance("logistic-robot", "radiation", 0, 100)
addCategoryResistance("construction-robot", "radiation", 0, 100)

--[[
data.raw["ammo-turret"]["cannon-turret"].attack_parameters.ammo_type.action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "uranium-cannon-projectile",
                starting_speed = 0.28
              }
            }
          }
        }
		--]]
	
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


--increase train weights (for more penetrative power in collisions; requires also increasing torque/braking and compensating fuel efficiency to match)
local heavyTrainFactor = 25

data.raw["locomotive"]["diesel-locomotive"].weight = data.raw["locomotive"]["diesel-locomotive"].weight*heavyTrainFactor --was 2000
data.raw["locomotive"]["diesel-locomotive"].braking_force = data.raw["locomotive"]["diesel-locomotive"].braking_force*heavyTrainFactor
--data.raw["locomotive"]["diesel-locomotive"].max_power = data.raw["locomotive"]["diesel-locomotive"].max_power*heavyTrainFactor
Modify_Power("diesel-locomotive", heavyTrainFactor)
data.raw["locomotive"]["diesel-locomotive"].energy_source.effectivity = data.raw["locomotive"]["diesel-locomotive"].energy_source.effectivity*heavyTrainFactor
addResistance("locomotive", "diesel-locomotive", "impact", 400, 99)
addResistance("cargo-wagon", "cargo-wagon", "impact", 400, 98)
if data.raw["locomotive"]["diesel-locomotive-2"] then
	data.raw["locomotive"]["diesel-locomotive-2"].weight = data.raw["locomotive"]["diesel-locomotive-2"].weight*heavyTrainFactor*1.6 --was 2000
	data.raw["locomotive"]["diesel-locomotive-2"].braking_force = data.raw["locomotive"]["diesel-locomotive-2"].braking_force*heavyTrainFactor*1.6
	--data.raw["locomotive"]["diesel-locomotive-2"].max_power = data.raw["locomotive"]["diesel-locomotive-2"].max_power*heavyTrainFactor*1.6
	Modify_Power("diesel-locomotive-2", heavyTrainFactor*1.6)
	data.raw["locomotive"]["diesel-locomotive-2"].energy_source.effectivity = data.raw["locomotive"]["diesel-locomotive-2"].energy_source.effectivity*heavyTrainFactor*1.6
	addResistance("locomotive", "diesel-locomotive-2", "impact", 400, 99)
	addResistance("cargo-wagon", "cargo-wagon-2", "impact", 400, 98)

	data.raw["locomotive"]["diesel-locomotive-3"].weight = data.raw["locomotive"]["diesel-locomotive-3"].weight*heavyTrainFactor*2.4 --was 2000
	data.raw["locomotive"]["diesel-locomotive-3"].braking_force = data.raw["locomotive"]["diesel-locomotive-3"].braking_force*heavyTrainFactor*2.4
	--data.raw["locomotive"]["diesel-locomotive-3"].max_power = data.raw["locomotive"]["diesel-locomotive-3"].max_power*heavyTrainFactor*2.4
	Modify_Power("diesel-locomotive-3", heavyTrainFactor*2.4)
	data.raw["locomotive"]["diesel-locomotive-3"].energy_source.effectivity = data.raw["locomotive"]["diesel-locomotive-3"].energy_source.effectivity*heavyTrainFactor*2.4
	addResistance("locomotive", "diesel-locomotive-3", "impact", 400, 99)
	addResistance("cargo-wagon", "cargo-wagon-3", "impact", 400, 98)
end