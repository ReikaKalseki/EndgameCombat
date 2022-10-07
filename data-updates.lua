require "functions"
require "config"

require("prototypes.recipe.recipe-updates")

require("prototypes.overrides")

require("prototypes.rangeturrets")
require("prototypes.item.compound-ammo")


data.raw["logistic-container"]["turret-logistic-interface"].resistances = createTotalResistance()
data.raw["constant-combinator"]["dome-circuit-connection"].resistances = createTotalResistance()

if Config.superBiters then
	data.raw.unit["behemoth-biter"].max_health = 10000
	addResistance("unit", "behemoth-biter", "laser", 2, 15)
end

if Config.superWorms then
	data.raw.turret["behemoth-worm-turret"].max_health = data.raw.unit["behemoth-biter"].max_health
end

local function createAlternateAcidCapsuleRecipe(fluid, amountScalar)
	if not data.raw.fluid[fluid] then return end
	local recname = "acid-capsule-with-" .. fluid
	data:extend({
	{
		type = "recipe",
		name = recname,
		enabled = "false",
		energy_required = 30,
		category = "crafting-with-fluid",
		ingredients =
		{
		  {"steel-plate", 5},
		  {"plastic-bar", 7},
		  {type="fluid", name = fluid, amount = 80*(amountScalar and amountScalar or 1)}
		},
		result = "acid-capsule"
	  }
	})
	table.insert(data.raw["technology"]["capsules"].effects, {type = "unlock-recipe", recipe = recname})
end

createAlternateAcidCapsuleRecipe("nitric-acid", 0.75)
createAlternateAcidCapsuleRecipe("hydrochloric-acid", 1)
createAlternateAcidCapsuleRecipe("hydrogen-chloride", 1)
createAlternateAcidCapsuleRecipe("lye", 1.25)

table.insert(data.raw.technology["discharge-defense-equipment"].prerequisites, "electrical-discharges")

data.raw.wall["stone-wall"].next_upgrade = "tough-wall"
data.raw.gate.gate.next_upgrade = "tough-gate"
data.raw["ammo-turret"]["gun-turret"].next_upgrade = "concussion-turret"
data.raw["electric-turret"]["laser-turret"].next_upgrade = "plasma-turret"

data:extend({{
	type = "virtual-signal",
	name = "orbital-detect-nest-spawn",
	icon = "__EndgameCombat__/graphics/icons/biter-nest-spawn.png",
	icon_size = 64,
	subgroup = "virtual-signal-special",
	order = name,
	hidden = true,
}})