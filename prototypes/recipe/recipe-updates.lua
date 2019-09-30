require "config"

local turretArmorSteel = 10

local function addPlateToTurret(turret, item, amt)
	if item == "cobalt" then item = "cobalt-steel" end
	local ing = data.raw.item[item]
	if not ing then ing = data.raw.item[item .. "-plate"] end
	if not ing then ing = data.raw.item[item .. "-alloy"] end
	if not ing then error("Could not find item " .. item .. " for turret " .. turret) end
	table.insert(data.raw["recipe"][turret].ingredients,{ing.name, amt})
	local tech = data.raw.technology[turret]
	if not tech then tech = data.raw.technology[turret .. "s"] end
	if not tech then error("Could not find tech for turret " .. turret) end
	local pre = item .. "-processing"
	if item == "cobalt-steel" then pre = "cobalt-processing" end
	if not data.raw.technology[pre] then
		pre = item .. "-mk01"
	end
	if not data.raw.technology[pre] then error("No technology for plate " .. item .. "!") end
	if item == "cobalt-steel" and mods["FTweaks"] and data.raw.technology["cobalt-processing"] then pre = "cobalt-processing-2" end
	table.insert(tech.prerequisites, pre)
end

if data.raw.item["titanium-plate"] then
	addPlateToTurret("plasma-turret", "titanium", 25)
	addPlateToTurret("cannon-turret", "cobalt", 50)
	addPlateToTurret("shockwave-turret", "nickel", 40)
	addPlateToTurret("acid-turret", "aluminium", 20)
	addPlateToTurret("lightning-turret", "tungsten", 10)
  
  table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"copper-tungsten-alloy", 25})
  table.insert(data.raw.technology["power-armor-mk3"].prerequisites, "tungsten-processing")
  table.insert(data.raw.technology["power-armor-mk3"].prerequisites, "nitinol-processing")
else
	turretArmorSteel = 50
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"steel-plate", 6})
  
  table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"steel-plate", 100})
table.insert(data.raw["recipe"]["acid-turret"].ingredients,{"steel-plate", --[[turretArmorSteel--]]40})
end

table.insert(data.raw["recipe"]["concussion-turret"].ingredients,{"steel-plate", --[[turretArmorSteel--]]25})
table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"steel-plate", turretArmorSteel})
table.insert(data.raw["recipe"]["cannon-turret"].ingredients,{"steel-plate", turretArmorSteel*2})
table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"steel-plate", math.floor(turretArmorSteel*0.8)})

if data.raw.item["speed-module-5"] then
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"speed-module-5", 10})
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"effectivity-module-5", 10})
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"productivity-module-5", 10})
end

if data.raw.item.resin then
	table.insert(data.raw.recipe["sticky-cheap"].ingredients, {type = "item", name = "resin", amount = 1})
	table.insert(data.raw.recipe["sticky-expensive"].ingredients, {type = "item", name = "resin", amount = 2})
else
	table.insert(data.raw.recipe["sticky-cheap"].ingredients, {type = "item", name = "wood", amount = 1})
	table.insert(data.raw.recipe["sticky-expensive"].ingredients, {type = "item", name = "wood", amount = 2})
end

if data.raw.fluid.chlorine then
	table.insert(data.raw.recipe["sticky-expensive"].ingredients, {type = "fluid", name = "chlorine", amount = 20})
	data.raw.recipe["sticky-expensive"].results[1].amount = 150 --from 120
end

if data.raw.technology["chemical-plant"] then
	table.insert(data.raw.technology["sticky-turrets"].prerequisites, "chemical-plant")
else
	table.insert(data.raw.technology["sticky-turrets"].effects, {type = "unlock-recipe", recipe = "chemical-plant"})
end

if data.raw.technology["chemical-processing-1"] then
	table.insert(data.raw.technology["sticky-turrets"].prerequisites, "chemical-processing-1")
	table.insert(data.raw.technology["sticky-ammo-2"].prerequisites, "chemical-processing-2")
end

if data.raw["generator-equipment"]["fusion-reactor-equipment"] then --some mods remove this
	table.insert(data.raw.recipe["destroyer-satellite"].ingredients, {"fusion-reactor-equipment", 1})
	table.insert(data.raw.technology["advanced-equipment"].prerequisites, "fusion-reactor-equipment")
	table.insert(data.raw.technology["orbital-destroyer"].prerequisites, "fusion-reactor-equipment")
elseif data.raw.item["vehicle-fusion-reactor-1"] then
	table.insert(data.raw.recipe["destroyer-satellite"].ingredients, {"vehicle-fusion-reactor-1", 1})
elseif data.raw["generator-equipment"]["vehicle-fusion-cell-1"] then
	table.insert(data.raw.recipe["destroyer-satellite"].ingredients, {"vehicle-fusion-cell-1", 1})
else
	table.insert(data.raw.recipe["destroyer-satellite"].ingredients, {"solar-panel-equipment", 50})
end

if data.raw.item["advanced-processing-unit"] then
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"advanced-processing-unit", 50})
else
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"advanced-circuit", 20})
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"processing-unit", 50})
end

if Config.spacePlasma then
	table.insert(data.raw["technology"]["plasma-turrets"].unit.ingredients,{"space-science-pack", 1})
	data.raw["technology"]["plasma-turrets"].unit.count = 500 --up from 200
end

if Config.spaceNukes then
	table.insert(data.raw["technology"]["nuclear-shells"].unit.ingredients,{"space-science-pack", 1})
end

local tankArmorSteel = 50

if data.raw.item["titanium-plate"] then
	table.insert(data.raw["recipe"]["better-tank"].ingredients,{"titanium-plate", 25})
else
	tankArmorSteel = 200
end

table.insert(data.raw["recipe"]["better-tank"].ingredients,{"steel-plate", tankArmorSteel})

if data.raw.item["tungsten-plate"] then
	table.insert(data.raw["recipe"]["better-tank"].ingredients,{"tungsten-plate", 25})
else
	table.insert(data.raw["recipe"]["better-tank"].ingredients,{"copper-plate", 50})
end

if data.raw.item["nitinol-alloy"] then
	table.insert(data.raw["recipe"]["better-tank"].ingredients, {"nitinol-alloy", 25})
	table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients, {"nitinol-alloy", 25})
else
	table.insert(data.raw["recipe"]["better-tank"].ingredients, {"plastic-bar", 50})
end

if data.raw.item["lithium-ion-battery"] then
	table.insert(data.raw["recipe"]["plasma-turret"].ingredients, {"lithium-ion-battery", 10})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "battery-2")
else
	table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"battery", 20})
end

if data.raw.item["silver-zinc-battery"] then
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"silver-zinc-battery", 50})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "battery-3")
else
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"accumulator", 40})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "electric-energy-accumulators")
end

if data.raw.item["substation-4"] then
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"substation-4", 8})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "electric-substation-4")
else
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"substation", 24})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "electric-energy-distribution-2")
end

if data.raw.item["electronic-components"] then
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"electronic-components", 30})
end