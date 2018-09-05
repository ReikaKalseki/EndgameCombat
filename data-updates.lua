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

table.insert(data.raw.technology["discharge-defense-equipment"].prerequisites, "electrical-discharges")