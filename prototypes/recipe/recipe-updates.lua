require "config"

--[[ gates it too late
if data.raw.item["gilded-copper-cable"] then

  table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"gilded-copper-cable", 40})
  table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"copper-cable", 20})
  table.insert(data.raw["technology"]["shockwave-turrets"].prerequisites,{"gold-processing", 20})
else
  table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"copper-cable", 100})
end
--]]

local turretArmorSteel = 10

if data.raw.item["titanium-plate"] then
  --table.insert(data.raw["recipe"]["concussion-turret"].ingredients,{"titanium-plate", 25})
  table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"titanium-plate", 25})
  table.insert(data.raw["recipe"]["cannon-turret"].ingredients,{"titanium-plate", 50})
  table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"titanium-plate", 10})
  --table.insert(data.raw["recipe"]["acid-turret"].ingredients,{"titanium-plate", 20})
  table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"titanium-plate", 4})
  
  table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"titanium-plate", 25})
else
  turretArmorSteel = 50
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"steel-plate", 6})
  
  table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"steel-plate", 100})
end

table.insert(data.raw["recipe"]["concussion-turret"].ingredients,{"steel-plate", --[[turretArmorSteel--]]25})
table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"steel-plate", turretArmorSteel})
table.insert(data.raw["recipe"]["cannon-turret"].ingredients,{"steel-plate", turretArmorSteel*2})
table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"steel-plate", math.floor(turretArmorSteel*0.8)})
table.insert(data.raw["recipe"]["acid-turret"].ingredients,{"steel-plate", --[[turretArmorSteel--]]40})

if data.raw.item["speed-module-5"] then
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"speed-module-5", 10})
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"effectivity-module-5", 10})
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"productivity-module-5", 10})
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
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"advanced-processing-unit", 50})
else
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"advanced-circuit", 20})
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"processing-unit", 50})
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
	table.insert(data.raw["recipe"]["better-tank"].ingredients,{"nitinol-alloy", 25})
	table.insert(data.raw["recipe"]["power-armor-3"].ingredients,{"nitinol-alloy", 25})
else
	table.insert(data.raw["recipe"]["better-tank"].ingredients,{"plastic-bar", 50})
end

if data.raw.item["lithium-ion-battery"] then
	table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"lithium-ion-battery", 10})
else
	table.insert(data.raw["recipe"]["plasma-turret"].ingredients,{"battery", 20})
end

if data.raw.item["silver-zinc-battery"] then
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"silver-zinc-battery", 50})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "battery-3")
else
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"electric-energy-accumulator", 40})
	table.insert(data.raw["technology"]["lightning-turrets"].prerequisites, "battery")
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