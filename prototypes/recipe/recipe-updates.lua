require "config"

require "__DragonIndustries__.recipe"
require "__DragonIndustries__.items"

createConversionRecipe("explosive-rocket", "napalm-rocket", true, "napalm-rockets")
--createConversionRecipe("spiked-wall", "tough-spiked-wall", true, "tough-spiked-walls")

local turretArmorSteel = 10

local function addPlateToTurret(turret, item, amt)
	if item == "cobalt" then item = "cobalt-steel" end
	local ing = data.raw.item[item]
	if not ing then ing = data.raw.item[item .. "-plate"] end
	if not ing then ing = data.raw.item[item .. "-alloy"] end
	if not ing and mods["bztitanium"] then return end
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

if Config.plasticShockwave then
	table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"advanced-circuit", 10})
	table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"electronic-circuit", 10})
else
	table.insert(data.raw["recipe"]["shockwave-turret"].ingredients,{"electronic-circuit", 40})
end

if data.raw.item["titanium-plate"] then
	addPlateToTurret("cannon-turret", "cobalt", 50)
	addPlateToTurret("shockwave-turret", "nickel", 40)
	addPlateToTurret("acid-turret", "aluminium", 20)
	addPlateToTurret("lightning-turret", "tungsten", 10)
	addPlateToTurret("plasma-turret", "titanium", 25)
  
  local ing = data.raw.item["copper-tungsten-alloy"]
  if not ing then ing = data.raw.item["tungsten-plate"] end
  if ing then
    table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{ing.name, 25})
  end
  if data.raw.technology["tungsten-processing"] then
    table.insert(data.raw.technology["power-armor-mk3"].prerequisites, "tungsten-processing")
  end
  if data.raw.technology["nitinol-processing"] then
    table.insert(data.raw.technology["power-armor-mk3"].prerequisites, "nitinol-processing")
  end
else
	turretArmorSteel = 50
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"steel-plate", 6})
  
  table.insert(data.raw["recipe"]["power-armor-mk3"].ingredients,{"steel-plate", 100})
table.insert(data.raw["recipe"]["acid-turret"].ingredients,{"steel-plate", --[[turretArmorSteel--]]40})
end

if data.raw.item["ruby-5"] then
	local lens0,lensrec0 = createBasicCraftingItem("turret-lens-0", "__EndgameCombat__/graphics/icons/turret-lens-0.png", {{"ruby-5", 40}}, 5)
	local lens1,lensrec1 = createBasicCraftingItem("turret-lens-1", "__EndgameCombat__/graphics/icons/turret-lens-1.png", {{"amethyst-5", 80}, {"topaz-5", 20}}, 10)
	local lens2,lensrec2 = createBasicCraftingItem("turret-lens-2", "__EndgameCombat__/graphics/icons/turret-lens-2.png", {{"sapphire-5", 75}, {"diamond-5", 40}}, 20)
	local lensD0,lensrecD0 = createBasicCraftingItem("dome-lens-0", "__EndgameCombat__/graphics/icons/dome-lens-0.png", {{"emerald-5", 100}}, 10)
	local lensD1,lensrecD1 = createBasicCraftingItem("dome-lens-1", "__EndgameCombat__/graphics/icons/dome-lens-1.png", {{"topaz-5", 50}}, 20)
	local lensD2,lensrecD2 = createBasicCraftingItem("dome-lens-2", "__EndgameCombat__/graphics/icons/dome-lens-2.png", {{"sapphire-5", 40}, {"diamond-5", 10}}, 40)
	if data.raw.item["silver-plate"] then
		table.insert(lensrec0.ingredients, {"gold-plate", 12})
		table.insert(lensrec0.ingredients, {"silver-plate", 30})
		
		table.insert(lensrecD0.ingredients, {"gold-plate", 25})
		table.insert(lensrecD0.ingredients, {"silver-plate", 200})
		
		table.insert(lensrecD0.ingredients, {"gold-plate", 25})
		table.insert(lensrecD0.ingredients, {"silver-plate", 200})
		
		table.insert(lensrecD1.ingredients, {"titanium-plate", 80})
		
		if data.raw.item["silicon-nitride"] then
			table.insert(lensrec1.ingredients, {"silicon-nitride", 24})
			table.insert(lensrecD2.ingredients, {"silicon-nitride", 80})
		else
			table.insert(lensrec1.ingredients, {"cobalt-steel-alloy", 24})
		end
		table.insert(lensrec2.ingredients, {"tungsten-carbide", 12})
		table.insert(lensrecD2.ingredients, {"tungsten-plate", 50})

		markForProductivityAllowed(lensrec0);
		markForProductivityAllowed(lensrec1);
		markForProductivityAllowed(lensrec2);
		markForProductivityAllowed(lensrecD0);
		markForProductivityAllowed(lensrecD1);
		markForProductivityAllowed(lensrecD2);
	end
	lens0.stack_size = 10
	lens1.stack_size = 10
	lens2.stack_size = 10
	data:extend({
		lens0, lens1, lens2, lensrec0, lensrec1, lensrec2,
		lensD0, lensD1, lensD2, lensrecD0, lensrecD1, lensrecD2
	})
	table.insert(data.raw.technology["laser-turret"].effects, {type = "unlock-recipe", recipe = lensrec0.name})
	table.insert(data.raw.technology["plasma-turrets"].effects, {type = "unlock-recipe", recipe = lensrec1.name})
	table.insert(data.raw.technology["lightning-turrets"].effects, {type = "unlock-recipe", recipe = lensrec2.name})
	table.insert(data.raw.recipe["laser-turret"].ingredients, {lens0.name, 1})
	table.insert(data.raw.recipe["plasma-turret"].ingredients, {lens1.name, 1})
	table.insert(data.raw.recipe["lightning-turret"].ingredients, {lens2.name, 1})
	
	table.insert(data.raw.technology["laser-turret"].prerequisites, "gem-processing-2")
	table.insert(data.raw.technology["plasma-turrets"].prerequisites, "gem-processing-2")
	table.insert(data.raw.technology["lightning-turrets"].prerequisites, "gem-processing-2")
	
	table.insert(data.raw.technology["shield-domes"].effects, {type = "unlock-recipe", recipe = lensrecD0.name})
	table.insert(data.raw.technology["shield-domes"].effects, {type = "unlock-recipe", recipe = lensrecD1.name})
	table.insert(data.raw.technology["shield-domes"].effects, {type = "unlock-recipe", recipe = lensrecD2.name})
	
	table.insert(data.raw.recipe["small-shield-dome"].ingredients, {lensD0.name, 2})
	table.insert(data.raw.recipe["medium-shield-dome"].ingredients, {lensD1.name, 5})
	table.insert(data.raw.recipe["big-shield-dome"].ingredients, {lensD2.name, 8})
	
	table.insert(data.raw.technology["shield-domes"].prerequisites, "gem-processing-2")
end

if data.raw.item["lead-plate"] then
	table.insert(data.raw["recipe"]["supercavitating-bullet-magazine"].ingredients,{"lead-plate", 10})
	data.raw["recipe"]["supercavitating-bullet-magazine"].ingredients[3][2] = data.raw["recipe"]["supercavitating-bullet-magazine"].ingredients[3][2]*0.8 --piercing ammo 10->8
	data.raw["recipe"]["supercavitating-bullet-magazine"].result_count = data.raw["recipe"]["supercavitating-bullet-magazine"].result_count*1.6 -- 10->16
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

if data.raw.item["insulated-cable"] then
	table.insert(data.raw["recipe"]["lightning-turret"].ingredients,{"insulated-cable", 100})
	
	table.insert(data.raw.recipe["small-shield-dome"].ingredients, {"insulated-cable", 30})
	table.insert(data.raw.recipe["medium-shield-dome"].ingredients, {"gilded-copper-cable", 200})
end

markForProductivityAllowed("sticky-cheap");
markForProductivityAllowed("sticky-expensive");
markForProductivityAllowed("biter-fuel");
markForProductivityAllowed("biter-cooking");

if data.raw.item["bp-biter-egg"] then
	data:extend({{
		type = "recipe",
		name = "biter-egg-decomposition",
		enabled = "true",
		ingredients = {{"bp-biter-egg", 1}},
		energy_required = 1,
		category = "crafting",
		result = "biter-flesh",
		result_count = 6,
	}});
end