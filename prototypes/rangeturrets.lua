require "config"
require "constants"

local baseturrets = {}
baseturrets = util.table.deepcopy(data.raw["ammo-turret"])
for _,v in pairs(data.raw["electric-turret"]) do 
	table.insert(baseturrets, v)
end
for _,v in pairs(data.raw["fluid-turret"]) do 
	table.insert(baseturrets, v)
end

local turrets = {}
for i = 1,#TURRET_RANGE_BOOSTS do
	for name,base in pairs(baseturrets) do
		local turret = util.table.deepcopy(base)
		turret.name = turret.name .. "-rangeboost-" .. i
		turret.localised_name = {"turrets.upgrade", {"entity-name."..base.name}, i}
		turret.attack_parameters.range = turret.attack_parameters.range+TURRET_RANGE_BOOST_SUMS[i]
		turret.order = "z"
		--log("Adding ranged L" .. i .. " for " .. name .. ", range = R+" .. TURRET_RANGE_BOOST_SUMS[i])
		table.insert(turrets, turret)
	end
end

for k,turret in pairs(turrets) do
	data:extend(
	{
		turret
	})
end