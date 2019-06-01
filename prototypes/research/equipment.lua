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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 30
    },
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
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 30
    },
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
        {"automation-science-pack", 4},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
        {"military-science-pack", 2},
      },
      time = 60
    },
    order = "a-f",
	icon_size = 128,
  },
})