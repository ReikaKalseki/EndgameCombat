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
      {"concrete", 5},
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
}
)