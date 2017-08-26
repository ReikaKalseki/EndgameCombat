require "functions"

require("prototypes.recipe.recipe-updates")

require("prototypes.overrides")

require("prototypes.rangeturrets")
require("prototypes.item.compound-ammo")


data.raw["logistic-container"]["turret-logistic-interface"].resistances = createTotalResistance()
data.raw["constant-combinator"]["dome-circuit-connection"].resistances = createTotalResistance()