require "config"
require "constants"

local MAKE_ITEMS = false

local baseturrets = {}
baseturrets = util.table.deepcopy(data.raw["ammo-turret"])
for _,v in pairs(data.raw["electric-turret"]) do 
	table.insert(baseturrets, v)
end
for _,v in pairs(data.raw["fluid-turret"]) do 
	table.insert(baseturrets, v)
end

local turrets = {}
local items = {}
for i = 1,#TURRET_RANGE_BOOSTS do
	for name,base in pairs(baseturrets) do
		local turret = util.table.deepcopy(base)
		turret.name = turret.name .. "-rangeboost-" .. i
		turret.localised_name = {"turrets.upgrade", {"entity-name." .. base.name}, i}
		turret.attack_parameters.range = turret.attack_parameters.range+TURRET_RANGE_BOOST_SUMS[i]
		turret.order = "z"
		if MAKE_ITEMS then
			turret.minable.result = turret.name
		end
		--log("Adding ranged L" .. i .. " for " .. name .. ", range = R+" .. TURRET_RANGE_BOOST_SUMS[i])
		table.insert(turrets, turret)
		
		if MAKE_ITEMS then
			local item = util.table.deepcopy(data.raw.item[base.minable.result])
			item.name = turret.name
			--item.localised_name = turret.localised_name
			item.order = "z"
			item.place_result = turret.name
			--log("Adding ranged L" .. i .. " for " .. name .. ", range = R+" .. TURRET_RANGE_BOOST_SUMS[i])
			table.insert(items, item)
		end
	end
end

for k,turret in pairs(turrets) do
	data:extend(
	{
		turret
	})
end

if MAKE_ITEMS then
	for k,item in pairs(items) do
		data:extend(
		{
			item
		})
	end
end