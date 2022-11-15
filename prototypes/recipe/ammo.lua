require "__DragonIndustries__.recipe"

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
    name = "sticky-cheap",
    enabled = "false",
	category = "chemistry",
    energy_required = 1,
    ingredients =
    {
		{type = "fluid", name = "water", amount = 50}
    },
    results = {
		{type = "fluid", name = "sticky", amount = 10}
	}
  },
    {
    type = "recipe",
    name = "sticky-expensive",
    enabled = "false",
    energy_required = 2,
	category = "chemistry",
    ingredients =
    {
		{type = "fluid", name = "heavy-oil", amount = 10}
    },
    results = {
		{type = "fluid", name = "sticky", amount = 120}
	}
  },
    {
    type = "recipe",
    name = "supercavitating-bullet-magazine",
    enabled = "false",
    energy_required = 9,
	category = "advanced-crafting",
    ingredients =
    {
      {"explosives", 2},
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
	category = "advanced-crafting",
	normal = {
		energy_required = 45,
		ingredients =
		{
		  {"steel-plate", 10},
		  {"rocket-control-unit", 1},
		  {"uranium-235", 12},
		  {"explosives", 80}
		},
    result = "neutron-shell"
	},
	expensive = {
		energy_required = 60,
		ingredients =
		{
		  {"steel-plate", 10},
		  {"rocket-control-unit", 4},
		  {"uranium-235", 20},
		  {"explosives", 100}
		},
    result = "neutron-shell"
	},
  },
      {
    type = "recipe",
    name = "neutron-rocket",
    enabled = "false",
	category = "advanced-crafting",
	normal = {
		energy_required = 45,
		ingredients =
		{
		  {"steel-plate", 10},
		  {"rocket-control-unit", 1},
		  {"processing-unit", 4},
		  {"uranium-235", 12},
		  {"explosives", 80},
		{"rocket", 1}
		},
    result = "neutron-rocket"
	},
	expensive = {
		energy_required = 60,
		ingredients =
		{
		  {"steel-plate", 10},
		  {"rocket-control-unit", 4},
		  {"processing-unit", 5},
		  {"uranium-235", 20},
		  {"explosives", 100},
		{"rocket", 1}
		},
    result = "neutron-rocket"
	},
  },
      {
    type = "recipe",
    name = "napalm-shell",
    enabled = "false",
	category = "advanced-crafting",
	normal = {
		energy_required = 45,
		ingredients =
		{
		  {"flamethrower-ammo", 4},
		  {"steel-plate", 10},
		  {"explosives", 20},
		  {"plastic-bar", 8}
		},
    result = "napalm-shell"
	},
	expensive = {
		energy_required = 60,
		ingredients =
		{
		  {"flamethrower-ammo", 10},
		  {"steel-plate", 20},
		  {"explosives", 25},
		  {"plastic-bar", 10}
		},
    result = "napalm-shell"
	},
  },
        {
    type = "recipe",
    name = "napalm-rocket",
    enabled = "false",
	category = "advanced-crafting",
	normal = {
		energy_required = 45,
		ingredients =
		{
		  {"flamethrower-ammo", 4},
		  {"steel-plate", 10},
		  {"explosives", 20},
		  {"plastic-bar", 8},
		{"rocket", 1}
		},
    result = "napalm-rocket",
	},
	expensive = {
		energy_required = 60,
		ingredients =
		{
		  {"flamethrower-ammo", 10},
		  {"steel-plate", 20},
		  {"explosives", 25},
		  {"plastic-bar", 10},
			{"rocket", 1}
		},
    result = "napalm-rocket",
	},
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