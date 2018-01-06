require "config"
require "constants"

data:extend(
{
    {
    type = "technology",
    name = "power-armor-3",
    icon = "__EndgameCombat__/graphics/technology/armor.png",
    prerequisites =
    {
      "military-4",
      "power-armor-2",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "power-armor-3"
      },
    },
    unit =
    {
      count = 600,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"high-tech-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "advanced-equipment",
    icon = "__EndgameCombat__/graphics/technology/armor.png",
    prerequisites =
    {
      "power-armor-3",
	  "discharge-defense-equipment",
	  "personal-laser-defense-equipment",
	  "night-vision-equipment",
	  "energy-shield-equipment",
	  "battery-equipment",
	  "solar-panel-equipment",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-laser-defense-equipment"
      },
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
		{"high-tech-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "better-tank",
    icon = "__EndgameCombat__/graphics/technology/tank.png",
    prerequisites =
    {
      "military-4",
      "tanks",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "better-tank"
      },
    },
    unit =
    {
      count = 500,
      ingredients =
      {
        {"science-pack-1", 4},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"military-science-pack", 2},
      },
      time = 60
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
})