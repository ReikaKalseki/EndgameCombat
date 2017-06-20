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
      {"stone-brick", 2},
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
    energy = 60,
    ingredients = {
		{"power-armor-mk2", 1},
		{"advanced-circuit", 20},
	},
    result = "power-armor-3"
  },
  
  {
    type = "recipe",
    name = "tintless-night-vision-equipment",
    enabled = false,
    energy = 2,
    ingredients = {
		{"night-vision-equipment", 1},
		{"advanced-circuit", 5},
		{"processing-unit", 5},
		{"electronic-circuit", 10},
	},
    result = "tintless-night-vision-equipment"
  },
  
  {
    type = "recipe",
    name = "advanced-laser-defense-equipment",
    enabled = false,
    energy = 40,
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
	energy = 30,
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
      {"iron-gear-wheel", 10},
      {"advanced-circuit", 5},
    },
	energy = 20,
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
	  --{"battery", 20},
    },
	energy = 30,
    result = "plasma-turret"
  },
 {
    type = "recipe",
    name = "cannon-turret",
    enabled = "false",
    ingredients =
    {
      {"gun-turret", 1},
      --{"steel-plate", 25},
      {"iron-gear-wheel", 40},
      {"advanced-circuit", 5},
      {"electronic-circuit", 20},
      {"stone", 10},
    },
    result = "cannon-turret"
  },
  
  --ammo
    {
    type = "recipe",
    name = "sulfur-bullet-magazine",
    enabled = "false",
    energy = 3,
	--category = "advanced-crafting",
    ingredients =
    {
      {"sulfur", 2},
      {"coal", 2},
      {"steel-plate", 1},
      {"copper-plate", 5}
    },
    result = "sulfur-bullet-magazine"
  },
      {
    type = "recipe",
    name = "sulfur-heavy-bullet-magazine",
    enabled = "false",
    energy = 4,
	category = "advanced-crafting",
    ingredients =
    {
      {"sulfur", 4},
      {"coal", 2},
      {"steel-plate", 2},
    },
    result = "sulfur-heavy-bullet-magazine"
  },
  --[[
    {
    type = "recipe",
    name = "nuke-shell",
    enabled = "false",
    energy = 45,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 6},
	  {"processing-unit",5}
    },
    result = "nuke-shell"
  },--]]
    {
    type = "recipe",
    name = "neutron-shell",
    enabled = "false",
    energy = 45,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 10},
	  {"processing-unit", 25}
    },
    result = "neutron-shell"
  },
      {
    type = "recipe",
    name = "napalm-shell",
    enabled = "false",
    energy = 45,
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
    name = "hiex-cannon-shell-big",
    enabled = "false",
    energy = 15,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 4},
      {"explosives", 12},
    },
    result = "hiex-cannon-shell-big"
  },
    {
    type = "recipe",
    name = "radiation-capsule",
    enabled = "false",
    energy = 40,
	category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 5},
      {"explosives", 1},
    },
    result = "radiation-capsule"
  },
      {
    type = "recipe",
    name = "acid-capsule",
    enabled = "false",
    energy = 30,
    category = "crafting-with-fluid",
    ingredients =
    {
      {"steel-plate", 5},
      {"plastic-bar", 7},
      {type="fluid", name = "sulfuric-acid", amount = 1}
    },
    result = "acid-capsule"
  }
}
)