 data:extend(
{
--walls
 {
    type = "recipe",
    name = "tough-wall",
    enabled = "false",
    ingredients =
    {
	  {"stone-wall", 1},
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

--misc
  {
    type = "recipe",
    name = "power-armor-3",
    enabled = false,
    energy_required = 60,
    ingredients = {
		{"power-armor-mk2", 1},
		{"advanced-circuit", 20},
	},
    result = "power-armor-3"
  },
  
  {
    type = "recipe",
    name = "advanced-laser-defense-equipment",
    enabled = false,
    energy_required = 40,
    ingredients = {
		{"personal-laser-defense-equipment", 1},
		{"plasma-turret", 5},
		{"processing-unit", 10},
		{"electronic-circuit", 25},
	},
    result = "advanced-laser-defense-equipment"
  },
  
    {
    type = "recipe",
    name = "better-tank",
    enabled = "false",
    ingredients =
    {	
      {"tank", 1},
      {"engine-unit", 24},
      {"iron-gear-wheel", 40},
      {"advanced-circuit", 25}
    },
    result = "better-tank"
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

--turrets
 {
    type = "recipe",
    name = "concussion-turret",
    enabled = "false",
    ingredients =
    {
      {"gun-turret", 1},
      {"iron-gear-wheel", 20},
      {"electronic-circuit", 25},
    },
	energy_required = 20,
    result = "concussion-turret"
  },
   {
    type = "recipe",
    name = "plasma-turret",
    enabled = "false",
    ingredients =
    {
      {"laser-turret", 1},
      {"iron-gear-wheel", 10},
      {"processing-unit", 5},
    },
	energy_required = 30,
    result = "plasma-turret"
  },
 {
    type = "recipe",
    name = "cannon-turret",
    enabled = "false",
    ingredients =
    {
      {"gun-turret", 1},
      {"iron-gear-wheel", 40},
      {"advanced-circuit", 5},
      {"electronic-circuit", 20},
      {"stone", 10},
    },
    result = "cannon-turret"
  },
 {
    type = "recipe",
    name = "shockwave-turret",
    enabled = "false",
    ingredients =
    {
      {"iron-stick", 20},
      {"copper-cable", 80},
      {"advanced-circuit", 10},
      {"electronic-circuit", 10},
    },
    result = "shockwave-turret"
  },
  
  --ammo
    {
    type = "recipe",
    name = "sulfur-bullet-magazine",
    enabled = "false",
    energy_required = 3,
	--category = "advanced-crafting",
    ingredients =
    {
      {"sulfur", 2},
      {"coal", 2},
      {"steel-plate", 1},
      {"copper-plate", 5},
    },
    result = "sulfur-bullet-magazine"
  },
      {
    type = "recipe",
    name = "sulfur-heavy-bullet-magazine",
    enabled = "false",
    energy_required = 4,
	category = "advanced-crafting",
    ingredients =
    {
      {"sulfur", 4},
      {"coal", 2},
      {"steel-plate", 2},
	  {"uranium-238", 5}
    },
    result = "sulfur-heavy-bullet-magazine"
  },
        {
    type = "recipe",
    name = "sulfur-heavy-bullet-magazine-conversion",
    enabled = "false",
    energy_required = 2,
	category = "advanced-crafting",
    ingredients =
    {
      {"sulfur-bullet-magazine", 1},
	  {"uranium-238", 5}
    },
    result = "sulfur-heavy-bullet-magazine"
  },
    {
    type = "recipe",
    name = "neutron-shell",
    enabled = "false",
    energy_required = 45,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 10},
	  {"processing-unit", 25},
	  {"uranium-235", 1},
	  {"explosives", 100}
    },
    result = "neutron-shell"
  },
      {
    type = "recipe",
    name = "neutron-rocket",
    enabled = "false",
    energy_required = 45,
	category = "advanced-crafting",
    ingredients =
    {
	  {"rocket", 1},
      {"steel-plate", 10},
	  {"processing-unit", 25},
	  {"uranium-235", 1},
	  {"explosives", 100}
    },
    result = "neutron-rocket"
  },
      {
    type = "recipe",
    name = "napalm-shell",
    enabled = "false",
    energy_required = 45,
	category = "advanced-crafting",
    ingredients =
    {
      {"flamethrower-ammo", 20},
	  {"steel-plate", 20},
	  {"explosives", 10},
      {"plastic-bar", 25}
    },
    result = "napalm-shell"
  },
        {
    type = "recipe",
    name = "napalm-rocket",
    enabled = "false",
    energy_required = 45,
	category = "advanced-crafting",
    ingredients =
    {
      {"flamethrower-ammo", 20},
	  {"steel-plate", 20},
	  {"explosives", 10},
      {"plastic-bar", 25},
      {"rocket", 1}
    },
    result = "napalm-rocket"
  },
    {
    type = "recipe",
    name = "hiex-cannon-shell-big",
    enabled = "false",
    energy_required = 15,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 4},
      {"explosives", 12},
	  {"uranium-238", 2}
    },
    result = "hiex-cannon-shell-big"
  },
    {
    type = "recipe",
    name = "radiation-capsule",
    enabled = "false",
    energy_required = 40,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 5},
      {"explosives", 1},
	  {"uranium-235", 1}
    },
    result = "radiation-capsule"
  },
      {
    type = "recipe",
    name = "acid-capsule",
    enabled = "false",
    energy_required = 30,
    category = "crafting-with-fluid",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 7},
      {type="fluid", name = "sulfuric-acid", amount = 80}
    },
    result = "acid-capsule"
  }
}
)

 data:extend(
{
 {
    type = "recipe",
    name = "biter-cooking",
    enabled = "true",
    ingredients = {{"biter-flesh", 5}},
    energy_required = 2,
    category = "smelting",
    result = "cooked-biter"
  },
   {
    type = "recipe",
    name = "biter-fuel",
    enabled = "false",
	icon = "__EndgameCombat__/graphics/icons/biter-fuel.png",
    ingredients = {
		{"biter-flesh", 25},
		{type="fluid", name="sulfuric-acid", amount=40}
	},
    energy_required = 10,
    category = "chemistry",
    result = "solid-fuel"
  }
})

table.insert(data.raw.technology["sulfur-processing"].effects, {type="unlock-recipe", recipe="biter-fuel"})