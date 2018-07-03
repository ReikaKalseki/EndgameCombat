 data:extend(
{
--walls
 {
    type = "recipe",
    name = "tough-wall",
    enabled = "false",
    ingredients =
    {
	  {"stone-wall", 2},
	  {"stone-brick", 10},
      {"refined-concrete", 5},
      {"steel-plate", 1}
    },
	category = "advanced-crafting",
    result = "tough-wall"
  },
   {
    type = "recipe",
    name = "tough-gate",
    enabled = "false",
    ingredients =
    {
	  {"gate", 1},
      {"stone-brick", 2},
      {"steel-plate", 1}
    },
	category = "advanced-crafting",
    result = "tough-gate"
  },
   {
    type = "recipe",
    name = "spiked-wall",
    enabled = "false",
    ingredients =
    {
	  {"stone-wall", 1},
      {"iron-gear-wheel", 2},
      {"copper-plate", 1}
    },
	category = "advanced-crafting",
    result = "spiked-wall"
  },
   {
    type = "recipe",
    name = "tough-spiked-wall",
    enabled = "false",
    ingredients =
    {
	  {"tough-wall", 1},
      {"iron-gear-wheel", 4},
      {"copper-plate", 2}
    },
	category = "advanced-crafting",
    result = "tough-spiked-wall"
  },
 {
    type = "recipe",
    name = "big-radar",
    enabled = "false",
    ingredients =
    {
	  {"radar", 1},
      {"advanced-circuit", 20},
      {"processing-unit", 10},
      {"iron-gear-wheel", 40},
      {"steel-plate", 20}
    },
	energy_required = 30,
    result = "big-radar"
  },
 {
    type = "recipe",
    name = "small-shield-dome",
    enabled = "false",
    ingredients =
    {
	  {"beacon", 1},
      {"energy-shield-equipment", 5},
      {"processing-unit", 25},
      {"steel-plate", 10},
    },
	energy_required = 10,
    result = "small-shield-dome"
  },
 {
    type = "recipe",
    name = "medium-shield-dome",
    enabled = "false",
    ingredients =
    {
	  {"small-shield-dome", 1},
      {"energy-shield-equipment", 20},
      {"processing-unit", 40},
    },
	energy_required = 20,
    result = "medium-shield-dome"
  },
 {
    type = "recipe",
    name = "big-shield-dome",
    enabled = "false",
    ingredients =
    {
	  {"medium-shield-dome", 1},
      {"energy-shield-mk2-equipment", 25},
    },
	energy_required = 30,
    result = "big-shield-dome"
  },
}
)