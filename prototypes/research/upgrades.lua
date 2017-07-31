require "config"
require "constants"

data:extend(
{
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
        {"military-science-pack", 1}
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
        {"military-science-pack", 1}
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
        {"science-pack-3", 1},
        {"military-science-pack", 1}
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
        {"military-science-pack", 1}
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1}
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
      count_formula = "2^(L-7)*100",
      ingredients =
      {
        {"military-science-pack", 1},
        {"science-pack-1", 8},
        {"science-pack-2", 4},
        {"science-pack-3", 2},
        {"high-tech-science-pack", 1},
        {"space-science-pack", 1},
      },
      time = 120
    },
    max_level = "infinite",
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
        {"military-science-pack", 1}
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
        {"military-science-pack", 1},
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
      count_formula = "2^(L-7)*100",
      ingredients =
      {
        {"military-science-pack", 1},
        {"science-pack-1", 8},
        {"science-pack-2", 4},
        {"science-pack-3", 2},
        {"high-tech-science-pack", 1},
        {"space-science-pack", 1},
      },
      time = 90
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-n-l",
	icon_size = 128,
  },
  
  --repair alloys
  {
    type = "technology",
    name = "healing-alloys-1",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[1]*60*100), tostring(REPAIR_FACTORS[1]*100), tostring(REPAIR_LIMITS[1])},
    prerequisites =
    {
      "better-turrets",
	  "military-4",
	  "advanced-material-processing-2"
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"biter-flesh", 8}
      },
      time = 60
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "healing-alloys-2",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[2]*60*100), tostring(REPAIR_FACTORS[2]*100), tostring(REPAIR_LIMITS[2])},
    prerequisites =
    {
      "healing-alloys-1",
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"biter-flesh", 12}
      },
      time = 75
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "healing-alloys-3",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[3]*60*100), tostring(REPAIR_FACTORS[3]*100), tostring(REPAIR_LIMITS[3])},
    prerequisites =
    {
      "healing-alloys-2",
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"biter-flesh", 16}
      },
      time = 90
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "healing-alloys-4",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[4]*60*100), tostring(REPAIR_FACTORS[4]*100), tostring(REPAIR_LIMITS[4])},
    prerequisites =
    {
      "healing-alloys-3",
    },
    unit =
    {
      count = 800,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"biter-flesh", 24}
      },
      time = 120
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "healing-alloys-5",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[5]*60*100), tostring(REPAIR_FACTORS[5]*100), tostring(REPAIR_LIMITS[5])},
    prerequisites =
    {
      "healing-alloys-4",
    },
    unit =
    {
      count = 1600,
      ingredients =
      {
        {"science-pack-1", 2},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"biter-flesh", 32}
      },
      time = 180
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  },
      {
    type = "technology",
    name = "shockwave-turret-damage-1",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turret-damage.png",
    effects =
    {
	
    },
    prerequisites = {"shockwave-turrets"},
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
    name = "shockwave-turret-damage-2",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turret-damage.png",
    effects =
    {
	
    },
    prerequisites = {"shockwave-turret-damage-1"},
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
    name = "shockwave-turret-damage-3",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turret-damage.png",
    effects =
    {
	
    },
    prerequisites = {"shockwave-turret-damage-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-c",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "shockwave-turret-damage-4",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turret-damage.png",
    effects =
    {
	
    },
    prerequisites = {"shockwave-turret-damage-3"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-d",
	icon_size = 128,
  },
  {
    type = "technology",
    name = "shockwave-turret-damage-5",
    icon = "__EndgameCombat__/graphics/technology/shockwave-turret-damage.png",
    effects =
    {
	
    },
    prerequisites = {"shockwave-turret-damage-4"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-n-e",
	icon_size = 128,
  },
}
)

local i = 6
while #REPAIR_CHANCES >= i do

	--log("Level " .. i .. ":")
	--log(REPAIR_CHANCES[i]*60*100 .. " R/s")
	--log(REPAIR_FACTORS[i]*100 .. "%")
	--log(REPAIR_LIMITS[i] .. " Limit")

	data:extend(
	{
	  {
		type = "technology",
		name = "healing-alloys-" .. i,
		icon = "__EndgameCombat__/graphics/technology/healalloy.png",
		localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[i]*60*100), tostring(REPAIR_FACTORS[i]*100), tostring(REPAIR_LIMITS[i])},
		prerequisites =
		{
		  "healing-alloys-" .. (i-1),
		},
		unit =
		{
		  count = math.ceil(1600*(1.5^(i-5))),
		  ingredients =
		  {
			{"science-pack-1", 2},
			{"science-pack-2", 1},
			{"science-pack-3", 1},
			{"military-science-pack", 1},
			{"high-tech-science-pack", 1},
			{"biter-flesh", 32+(16*(i-5))}
		  },
		  time = 180+60*(i-5)
		},
		upgrade = true,
		order = "a-f",
		icon_size = 128,
	  },
	}
	)
	i = i+1
end

for l = 1,#TURRET_RANGE_BOOSTS do
	local packs = {
		{"science-pack-1", 1},
		{"science-pack-2", 1}
	}
	
	if l >= 3 then
		packs[#packs+1] = {"military-science-pack", 1}
	end	
	if l >= 5 then
		packs[#packs+1] = {"science-pack-3", 1}
	end	
	if l >= 7 then
		packs[#packs+1] = {"high-tech-science-pack", 1}
	end
	if l >= 10 then
		packs[#packs+1] = {"space-science-pack", 1}
	end
	
	local prereq = {}
	if l > 1 then
		table.insert(prereq, "turret-range-" .. (l-1))
	else
		table.insert(prereq, "turrets")
		table.insert(prereq, "military")
	end
	
	if l == 3 then
		table.insert(prereq, "military-2")
	end
	if l == 5 then
		table.insert(prereq, "military-3")
	end
	if l == 7 then
		table.insert(prereq, "military-4")
	end
		
	data:extend(
	{	
		{
			type = "technology",
			name = "turret-range-" .. l,
			icon = "__EndgameCombat__/graphics/technology/turret-range.png",
			localised_description = {"technology-description.turret-range", tostring(TURRET_RANGE_BOOSTS[l]), tostring(TURRET_RANGE_BOOST_SUMS[l])},
			prerequisites = prereq,
			unit =
			{
			  count = math.ceil(100*(2^(l-1))),
			  ingredients = packs,
			  time = 60+20*(l-1)
			},
			upgrade = true,
			order = "a-f",
			icon_size = 128,
		},
	})
	i = i+1
end
