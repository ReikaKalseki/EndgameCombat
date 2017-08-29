require "config"
require "constants"

data:extend(
{
--walls
    {
    type = "technology",
    name = "spiked-walls",
    icon = "__EndgameCombat__/graphics/technology/spiked-walls.png",
    prerequisites =
    {
	  "stone-walls",
	  "steel-processing",
      "military-3",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "spiked-wall"
      },
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
      time = 20
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "tough-walls",
    icon = "__EndgameCombat__/graphics/technology/tough-walls.png",
    prerequisites =
    {
	  "stone-walls",
	  "steel-processing",
	  "concrete",
      "military-2",
	  "gates",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "tough-wall"
      },
	  {
        type = "unlock-recipe",
        recipe = "tough-gate"
      },
    },
    unit =
    {
      count = 75,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        --{"science-pack-3", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "tough-spiked-walls",
    icon = "__EndgameCombat__/graphics/technology/tough-spiked-walls.png",
    prerequisites =
    {
	  "tough-walls",
	  "spiked-walls",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "tough-spiked-wall"
      },
    },
    unit =
    {
      count = 125,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
      },
      time = 40
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },

  --others
    {
    type = "technology",
    name = "big-radar",
    icon = "__EndgameCombat__/graphics/technology/radar.png",
    prerequisites =
    {
      "military-4",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-radar"
      },
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 32,
  },
    {
    type = "technology",
    name = "shield-domes",
    icon = "__EndgameCombat__/graphics/technology/domes.png",
    prerequisites =
    {
      "military-4",
      "energy-shield-mk2-equipment",
      "effect-transmission",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "small-shield-dome"
      },
      {
        type = "unlock-recipe",
        recipe = "medium-shield-dome"
      },
      {
        type = "unlock-recipe",
        recipe = "big-shield-dome"
      },
    },
    unit =
    {
      count = 1000,
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
    name = "orbital-destroyer",
    icon = "__EndgameCombat__/graphics/technology/orbital.png",
    prerequisites =
    {
      "military-4",
	  "rocket-silo",
	  "plasma-turrets",
	  "nuclear-power",
	  "fusion-reactor-equipment",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "orbital-destroyer"
      },
      {
        type = "unlock-recipe",
        recipe = "destroyer-satellite"
      },
      {
        type = "unlock-recipe",
        recipe = "orbital-manual-target"
      },
      {
        type = "unlock-recipe",
        recipe = "orbital-scanner"
      },
    },
    unit =
    {
      count = 2500,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
        {"high-tech-science-pack", 1},
        {"space-science-pack", (Config.spacePlasma or Config.spaceNukes) and 10 or 1},
      },
      time = 90
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "electric-defence",
    icon = "__EndgameCombat__/graphics/technology/electric-defence.png",
    prerequisites =
    {
      "military-3",
      "advanced-electronics",
      "electric-energy-distribution-2",
    },
	effects =
    {--[[
      {
        type = "unlock-recipe",
        recipe = "big-radar"
      },--]]
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
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
    name = "logistic-defence",
    icon = "__EndgameCombat__/graphics/technology/logistic.png",
    prerequisites =
    {
      "military-3",
      "logistic-robotics",
      "combat-robotics",
    },
	effects =
    {--[[
      {
        type = "unlock-recipe",
        recipe = "big-radar"
      },--]]
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "logistic-defence-2",
    icon = "__EndgameCombat__/graphics/technology/logistic.png",
    prerequisites =
    {
      "logistic-defence",
    },
	effects =
    {--[[
      {
        type = "unlock-recipe",
        recipe = "big-radar"
      },--]]
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
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
})