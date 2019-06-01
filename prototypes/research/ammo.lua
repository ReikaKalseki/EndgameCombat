require "config"
require "constants"

data:extend(
{
  {
    type = "technology",
    name = "sticky-ammo-2",
    icon = "__EndgameCombat__/graphics/technology/sticky-turrets.png",
    prerequisites =
    {
	  "sticky-turrets",
	  "oil-processing",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sticky-expensive"
      },
    },
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 20
    },
    order = "a-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "fire-ammo",
    icon = "__EndgameCombat__/graphics/technology/fire-ammo.png",
    prerequisites =
    {
	  "flammables",
      "military-2",
      "sulfur-processing",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sulfur-bullet-magazine"
      },
      {
        type = "unlock-recipe",
        recipe = "sulfur-bullet-magazine-conversion"
      },
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 40
    },
    order = "a-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "fire-ammo-2",
    icon = "__EndgameCombat__/graphics/technology/fire-ammo.png",
    prerequisites =
    {
	  "fire-ammo",
	  "uranium-ammo",
      "military-4",
    },
	effects =
    {
	   {
        type = "unlock-recipe",
        recipe = "sulfur-heavy-bullet-magazine"
      },
	   {
        type = "unlock-recipe",
        recipe = "sulfur-heavy-bullet-magazine-conversion"
      },
    },
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 40
    },
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "napalm-shells",
    icon = "__EndgameCombat__/graphics/technology/napalm-shells.png",
    prerequisites =
    {
	  "fire-ammo",
      "military-3",
	  "tanks"
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "napalm-shell"
      }
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 4},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 60
    },
    order = "a-f",
	icon_size = 32,
  },
      {
    type = "technology",
    name = "napalm-rockets",
    icon = "__EndgameCombat__/graphics/technology/napalm-rockets.png",
    prerequisites =
    {
	  "napalm-shells",
	  "rocketry",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "napalm-rocket"
      }
    },
    unit =
    {
      count = 20,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 15
    },
    order = "a-f",
	icon_size = 32,
  },
  
  {
    type = "technology",
    name = "hi-ex-shells",
    icon = "__EndgameCombat__/graphics/technology/hi-ex-shells.png",
    prerequisites =
    {
	  "explosives",
      "tanks",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "hiex-cannon-shell-big"
      },
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 40
    },
    order = "a-f",
	icon_size = 32,
  },
    {
    type = "technology",
    name = "nuclear-shells",
    icon = "__EndgameCombat__/graphics/technology/nuke-shells.png",
    prerequisites =
    {
	  "military-4",
      "hi-ex-shells",
	  "rocketry",
	  "atomic-bomb"
    },
	effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "radiation-capsule"
      },
	        {
        type = "unlock-recipe",
        recipe = "neutron-shell"
      },
	  	        {
        type = "unlock-recipe",
        recipe = "neutron-rocket"
      },
    },
    unit =
    {
      count = 7500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 240
    },
    order = "a-f",
	icon_size = 32,
  },
      {
    type = "technology",
    name = "capsules",
    icon = "__EndgameCombat__/graphics/technology/capsules.png",
    prerequisites =
    {
	  "military-3",
      "sulfur-processing",
      "advanced-oil-processing",
    },
	effects =
    {
	    {
        type = "unlock-recipe",
        recipe = "acid-capsule"
      },
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 40
    },
    order = "a-f",
	icon_size = 32,
  },
})