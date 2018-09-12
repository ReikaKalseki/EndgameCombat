require "config"
require "constants"

data:extend(
{
  {
    type = "technology",
    name = "better-turrets",
    icon = "__EndgameCombat__/graphics/technology/turrets.png",
    prerequisites =
    {
	  "military-2",
      "electronics",
      "turrets",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "concussion-turret"
      },
    },
    unit =
    {
      count = 80,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
		{"military-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "plasma-turrets",
    icon = "__EndgameCombat__/graphics/technology/plasma-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "plasma-turret"
      },
    },
    prerequisites =
    {
      "laser-turrets",
	  "better-turrets",
	  "military-4",
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
		{"high-tech-science-pack", 1},
		{"military-science-pack", 1},
      },
      time = 45
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "acid-turrets",
    icon = "__EndgameCombat__/graphics/technology/acid-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "acid-turret"
      },
    },
    prerequisites =
    {
      "fluid-handling",
	  "better-turrets",
	  "sulfur-processing",
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
		{"military-science-pack", 1},
      },
      time = 45
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "sticky-turrets",
    icon = "__EndgameCombat__/graphics/technology/sticky-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sticky-turret"
      },
      {
        type = "unlock-recipe",
        recipe = "glue-cheap"
      },
    },
    prerequisites =
    {
      "fluid-handling",
	  "better-turrets",
    },
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
		{"military-science-pack", 1},
      },
      time = 45
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "cannon-turrets",
    icon = "__EndgameCombat__/graphics/technology/cannon-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "cannon-turret"
      },
	  {
        type = "unlock-recipe",
        recipe = "cannon-shell-magazine"
      },
	  {
        type = "unlock-recipe",
        recipe = "explosive-cannon-shell-magazine"
      },
	  {
        type = "unlock-recipe",
        recipe = "uranium-cannon-shell-magazine"
      },
	  {
        type = "unlock-recipe",
        recipe = "explosive-uranium-cannon-shell-magazine"
      },
    },
    prerequisites =
    {
      "explosives",
	  "better-turrets",
	  "military-3",
	  "tanks",
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
      },
      time = 45
    },
    upgrade = false,
    order = "a-f",
	icon_size = 128,
  },
    
    {
    type = "technology",
    name = "shockwave-turrets",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "shockwave-turret"
      },
    },
    prerequisites =
    {
      --"discharge-defense-equipment",
	  "better-turrets",
	  --"military-3",
	  --"electric-energy-distribution-2",
	  "electrical-discharges",
    },
    unit =
    {
      count = 60,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        --{"science-pack-3", 1},
        {"military-science-pack", 1},
      },
      time = 30
    },
    upgrade = false,
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "last-stand-turrets",
    icon = "__EndgameCombat__/graphics/technology/last-stand-turrets-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "last-stand-turret"
      },
    },
    prerequisites =
    {
	  "better-turrets",
	  "land-mine",
	  "flammables",
    },
    unit =
    {
      count = 250,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
      },
      time = 30
    },
    upgrade = false,
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "lightning-turrets",
    icon = "__EndgameCombat__/graphics/technology/lightning-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "lightning-turret"
      },
    },
    prerequisites =
    {
	  "better-turrets",
	  "military-4",
	  "shockwave-turrets",
	  "advanced-electronics-2",
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
        {"high-tech-science-pack", 1},
      },
      time = 30
    },
    upgrade = false,
    order = "a-f",
	icon_size = 128,
  },
})