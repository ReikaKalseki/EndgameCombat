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

if data.raw.item["sodium-hydroxide"] then
	local lye = table.deepcopy(data.raw.fluid.water)
	lye.name = "lye"
	lye.base_color = {r=0.75, g=0.75, b=0.85}
	lye.flow_color = {r=0.8, g=0.8, b=0.9}
	lye.icon = "__EndgameCombat__/graphics/icons/lye.png"
	lye.icon_size = 32
	
	data:extend(
	{
	  lye,
	  {
		type = "recipe",
		name = "lye",
		category = "chemistry",
		icon = lye.icon,
		icon_size = lye.icon_size,
		energy_required = 3,
		enabled = "false",
		subgroup = "fluid",
		ingredients = {
		  {type="item", name="sodium-hydroxide", amount=2},
		  {type="fluid", name="lye", amount=10},
		},
		results = {
			{type="fluid", name="lye", amount=10}
		},
		crafting_machine_tint =
		{
		  primary = lye.base_color,
		  secondary = lye.base_color,
		  tertiary = lye.base_color,
		  quaternary = lye.base_color,
		}
	  }
	})
	
	table.insert(data.raw["fluid-turret"]["acid-turret"].attack_parameters.fluids, {type = "lye", damage_modifier = 1.4})
end

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