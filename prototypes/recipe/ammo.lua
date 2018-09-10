 data:extend(
{
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
    name = "sulfur-bullet-magazine-conversion",
    enabled = "false",
    energy_required = 3,
	--category = "advanced-crafting",
    ingredients =
    {
      {"sulfur", 2},
      {"coal", 2},
      {"piercing-rounds-magazine", 1},
    },
    result = "sulfur-bullet-magazine"
  },
    {
    type = "recipe",
    name = "supercavitating-bullet-magazine",
    enabled = "false",
    energy_required = 9,
	category = "advanced-crafting",
    ingredients =
    {
      {"explosives", 4},
      {"plastic-bar", 1},
      {"piercing-rounds-magazine", 10},
    },
    result = "supercavitating-bullet-magazine",
	result_count = 10
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