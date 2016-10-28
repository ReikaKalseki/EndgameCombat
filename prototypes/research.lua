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
        {"science-pack-3", 1},
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
      "military-3",
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
      },
      time = 40
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },

--misc
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
        {"alien-science-pack", 1},
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
	  "fusion-reactor-equipment",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-laser-defense-equipment"
      },
      {
        type = "unlock-recipe",
        recipe = "tintless-night-vision-equipment"
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
        {"alien-science-pack", 1},
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
        {"alien-science-pack", 2},
      },
      time = 60
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },

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
        {"alien-science-pack", 1},
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
        {"alien-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },

--ammo
  {
    type = "technology",
    name = "fire-ammo",
    icon = "__EndgameCombat__/graphics/technology/fire-ammo.png",
    prerequisites =
    {
	  "flammables",
      "military-3",
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
        recipe = "sulfur-heavy-bullet-magazine"
      },
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
      },
      time = 40
    },
    upgrade = true,
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
      "military-4"
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
        {"science-pack-1", 4},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
        {"alien-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
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
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
      },
      time = 40
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "nuclear-shells",
    icon = "__EndgameCombat__/graphics/technology/nuke-shells.png",
    prerequisites =
    {
	  "military-4",
      "hi-ex-shells",
    },
	effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nuke-shell"
      },
	        {
        type = "unlock-recipe",
        recipe = "radiation-capsule"
      },
	        {
        type = "unlock-recipe",
        recipe = "neutron-shell"
      },
    },
    unit =
    {
      count = 800,
      ingredients =
      {
        {"science-pack-1", 8},
        {"science-pack-2", 4},
        {"science-pack-3", 2},
        {"alien-science-pack", 1},
      },
      time = 240
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "capsules",
    icon = "__EndgameCombat__/graphics/technology/capsules.png",
    prerequisites =
    {
	  "military-4",
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
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
      },
      time = 40
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },

--turrets
  {
    type = "technology",
    name = "better-turrets",
    icon = "__EndgameCombat__/graphics/technology/turrets.png",
    prerequisites =
    {
	  "military-4",
      "advanced-electronics-2",
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
      count = 100,
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
    },
    prerequisites =
    {
      "explosives",
	  "better-turrets",
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1},
      },
      time = 45
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  
  --upgrades
    {
    type = "technology",
    name = "concussion-turret-damage-1",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
      {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.1"
      }
    },
    prerequisites = {"better-turrets"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-o-a",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "concussion-turret-damage-2",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
      {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.1"
      }
    },
    prerequisites = {"concussion-turret-damage-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-o-b",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "concussion-turret-damage-3",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
      {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"concussion-turret-damage-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-o-c",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "concussion-turret-damage-4",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
      {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"concussion-turret-damage-3"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-o-d",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "concussion-turret-damage-5",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
     {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"concussion-turret-damage-4"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-o-e",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "concussion-turret-damage-6",
    icon = "__EndgameCombat__/graphics/technology/concussion-turret-damage.png",
    effects =
    {
      {
        type = "turret-attack",
        turret_id = "concussion-turret",
        modifier = "0.4"
      }
    },
    prerequisites = {"concussion-turret-damage-5"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-o-f",
	icon_size = 128,
  },
  
    {
    type = "technology",
    name = "plasma-turret-damage-1",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.1"
      }
    },
    prerequisites = {"plasma-turrets"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-a",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-2",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.1"
      }
    },
    prerequisites = {"plasma-turret-damage-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-b",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-3",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"plasma-turret-damage-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-c",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-4",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"plasma-turret-damage-3"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-d",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-5",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"plasma-turret-damage-4"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-e",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-6",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.4"
      }
    },
    prerequisites = {"plasma-turret-damage-5"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-7",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.4"
      }
    },
    prerequisites = {"plasma-turret-damage-6"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 3},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-8",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.5"
      }
    },
    prerequisites = {"plasma-turret-damage-7"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 4},
        {"science-pack-2", 3},
        {"science-pack-3", 2}
      },
      time = 90
    },
    upgrade = true,
    order = "e-n-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-9",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.5"
      }
    },
    prerequisites = {"plasma-turret-damage-8"},
    unit =
    {
      count = 800,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 6},
        {"science-pack-2", 4},
        {"science-pack-3", 2}
      },
      time = 90
    },
    upgrade = true,
    order = "e-n-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-damage-10",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-damage.png",
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "plasma-turret",
        modifier = "0.6"
      }
    },
    prerequisites = {"plasma-turret-damage-9"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 8},
        {"science-pack-2", 4},
        {"science-pack-3", 2}
      },
      time = 120
    },
    upgrade = true,
    order = "e-n-f",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "plasma-turret-speed-1",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"plasma-turrets"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-g",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-speed-2",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.2"
      }
    },
    prerequisites = {"plasma-turret-speed-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-n-h",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-speed-3",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.3"
      }
    },
    prerequisites = {"plasma-turret-speed-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-i",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-speed-4",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.3"
      }
    },
    prerequisites = {"plasma-turret-speed-3"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-j",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-speed-5",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.3"
      }
    },
    prerequisites = {"plasma-turret-speed-4"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-k",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "plasma-turret-speed-6",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.3"
      }
    },
    prerequisites = {"plasma-turret-speed-5"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 2},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "plasma-turret-speed-7",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.4"
      }
    },
    prerequisites = {"plasma-turret-speed-6"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 3},
        {"science-pack-2", 2},
        {"science-pack-3", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "plasma-turret-speed-8",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.5"
      }
    },
    prerequisites = {"plasma-turret-speed-7"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 4},
        {"science-pack-2", 3},
        {"science-pack-3", 2}
      },
      time = 90
    },
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "plasma-turret-speed-9",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.5"
      }
    },
    prerequisites = {"plasma-turret-speed-8"},
    unit =
    {
      count = 800,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 6},
        {"science-pack-2", 4},
        {"science-pack-3", 2}
      },
      time = 90
    },
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
  
  {
    type = "technology",
    name = "plasma-turret-speed-10",
    icon = "__EndgameCombat__/graphics/technology/plasma-turret-speed.png",
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "plasma-turret",
        modifier = "0.5"
      }
    },
    prerequisites = {"plasma-turret-speed-9"},
    unit =
    {
      count = 1200,
      ingredients =
      {
        {"alien-science-pack", 1},
        {"science-pack-1", 8},
        {"science-pack-2", 4},
        {"science-pack-3", 2}
      },
      time = 90
    },
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
}
)

