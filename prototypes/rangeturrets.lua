require "config"
require "constants"
require "functions"

local MAKE_ITEMS = true--false

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
	for _,base in pairs(baseturrets) do
		local turret = util.table.deepcopy(base)
		turret.name = turret.name .. "-rangeboost-" .. i
		turret.localised_name = {"turrets.upgrade", {"entity-name." .. base.name}, i}
		turret.attack_parameters.range = turret.attack_parameters.range+TURRET_RANGE_BOOST_SUMS[i]
		turret.order = "z"
		if MAKE_ITEMS and turret.minable and turret.minable.result then
			turret.minable.result = turret.name
		end
		--log("Adding ranged L" .. i .. " for " .. base.name .. ", range = R+" .. TURRET_RANGE_BOOST_SUMS[i])
		table.insert(turrets, turret)
		
		if MAKE_ITEMS and base.minable and base.minable.result then
			local item = util.table.deepcopy(data.raw.item[base.minable.result])
			item.name = turret.name
			item.localised_name = base.localised_name--turret.localised_name
			item.order = "z"
			item.place_result = turret.name
			item.hidden = true
			--log("Adding ranged L" .. i .. " for " .. base.name .. ", range = R+" .. TURRET_RANGE_BOOST_SUMS[i])
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

--[[
for _,base in pairs(baseturrets) do
	local turret = util.table.deepcopy(base)
	turret.name = base.name .. "-range-blueprint"
	turret.localised_name = base.localised_name
	turret.order = "z"
	log("Adding BP'ed clone for " .. base.name .. " > " .. turret.name)
	data:extend(
	{
		turret
	})
	
	data:extend({
		{
			type = "item",
			name = turret.name,
			localised_name = base.localised_name,
			icon = "__base__/graphics/icons/radar.png", --temp
			flags = {"goes-to-main-inventory"},
			subgroup = "defensive-structure",
			order = "z",
			place_result = turret.name,
			stack_size = 1
		}
	})
end
--]]

if MAKE_ITEMS then
	for k,item in pairs(items) do
		data:extend(
		{
			item
		})
	end
end