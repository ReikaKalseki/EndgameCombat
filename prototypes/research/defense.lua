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
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 20
    },
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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        --{"chemical-science-pack", 1},
      },
      time = 30
    },
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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 40
    },
    order = "a-f",
	icon_size = 128,
  },

  --others
    {
    type = "technology",
    name = "electrical-discharges",
    icon = "__EndgameCombat__/graphics/technology/discharge.png",
    prerequisites =
    {
      "military-2",
      "electric-energy-distribution-1",
    },
	effects =
    {

    },
    unit =
    {
      count = 40,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "big-radar",
    icon = "__EndgameCombat__/graphics/technology/radar.png",
    prerequisites =
    {
      "military-3",
	  "advanced-electronics-2"
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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "shield-domes",
    icon = "__EndgameCombat__/graphics/technology/domes.png",
    prerequisites =
    {
      "military-3",
      "energy-shield-mk2-equipment",
      "effect-transmission",
	  "advanced-electronics-2",
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
    name = "orbital-destroyer",
    icon = "__EndgameCombat__/graphics/technology/orbital.png",
    prerequisites =
    {
      "military-4",
	  "rocket-silo",
	  "plasma-turrets",
	  "nuclear-power",
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
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", (Config.spacePlasma or Config.spaceNukes) and 10 or 1},
      },
      time = 90
    },
    order = "a-f",
	icon_size = 128,
  },
})

for type,vals in pairs(RETALIATIONS) do
	for level,vals2 in pairs(vals) do
	
		local name = type .. "-retaliation-" .. level
		
		local ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
		}
		if level > (type == "radar" and 3 or 2) then
			table.insert(ingredients, {"chemical-science-pack", 1})
		end
		if level > 1 then
			table.insert(ingredients, {"military-science-pack", 1})
		end
		if level > 5 then
			table.insert(ingredients, {"utility-science-pack", 1})
		end
		if level > 8 then
			table.insert(ingredients, {"space-science-pack", 1})
		end
		
		local prerequisites = {}
		if level > 1 then
			table.insert(prerequisites, type .. "-retaliation-" .. (level-1))
		else
			table.insert(prerequisites, "electrical-discharges")
			if type == "radar" then
				table.insert(prerequisites, "military")
			else
				table.insert(prerequisites, "military-2")
			end
			if type == "electric" then
				table.insert(prerequisites, "advanced-electronics")
			elseif type == "radar" then
				if data.raw.technology["radar-2"] then
					table.insert(prerequisites, "radar-2")
				end
			elseif type == "robot" then
				table.insert(prerequisites, "logistic-robotics")
				table.insert(prerequisites, "combat-robotics")
			end
		end
		
		data:extend({
			{
			type = "technology",
			name = name,
			icon = "__EndgameCombat__/graphics/technology/" .. type .. "-retaliation.png",
			localised_name = {"retaliation-name." .. type, tostring(level)},
			prerequisites = prerequisites,
			effects =
			{
			  {
				type = "nothing",
				effect_description = {"modifier-description.retaliation-" .. type, vals2.display1, vals2.display2},	
			  },
			},
			unit =
			{
			  count = 80*level,
			  ingredients = ingredients,
			  time = 40
			},
			upgrade = level > 1,
			order = "a-f",
			icon_size = 128,
		  },
		})
	end
end