require "config"
require "constants"
require "functions"
require "shield-domes"

local function duplicateTurretDamageBoost(tech, from, to)
	local base = nil
	--log("Checking tech " .. tech.name .. " for " .. from)
	for _,effect in pairs(tech.effects) do
		--log("Found type " .. effect.type)
		if effect.type == "turret-attack" then
			if effect.turret_id == from then
				base = effect
				break
			end
		end
		if effect.type == "ammo-damage" then
			if effect.ammo_category == from then
				base = effect
				break
			end
		end
		if effect.type == "gun-speed" then
			if effect.ammo_category == from then
				base = effect
				break
			end
		end
	end
	if base then
		local eff = table.deepcopy(base)
		eff.turret_id = to
		eff.ammo_category = to
		table.insert(tech.effects, eff)
	end
end

for name,tech in pairs(data.raw.technology) do
	if string.find(name, "turret-damage", 1, true) or string.find(name, "turret-speed", 1, true) then
		duplicateTurretDamageBoost(tech, "gun-turret", "concussion-turret")
		duplicateTurretDamageBoost(tech, "laser-turret", "plasma-turret")
	end
end

local function createShockwaveDmgUpgrade(lvl)
	return {
		type = "nothing",
		effect_description = {"modifier-description.shockwave-damage", tostring(40), tostring(40*lvl)},	
	}
end

data:extend(
{
    {
    type = "technology",
    name = "turret-logistics",
    icon = "__EndgameCombat__/graphics/technology/turret-logistics.png",
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.turret-logistic-capability"},
      }
    },
    prerequisites = {"better-turrets", "logistic-robotics", "logistics-3"},
    unit =
    {
      count = 80,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    upgrade = true,
    order = "e-o-a",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "turret-auto-logistics",
    icon = "__EndgameCombat__/graphics/technology/turret-logistics.png",
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.turret-auto-logistic-capability"},
      }
    },
    prerequisites = {"turret-logistics", "logistic-system"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 30
    },
    upgrade = true,
    order = "e-o-a",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "turret-monitoring",
    icon = "__EndgameCombat__/graphics/technology/turret-monitoring.png",
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.turret-monitoring"},
      }
    },
    prerequisites = {"turrets", "electronics", "automation"},
    unit =
    {
      count = 20,
      ingredients =
      {
        {"automation-science-pack", 1},
      },
      time = 30
    },
    order = "e-o-a",
	icon_size = 128,
  },
})

data:extend(
{  
  --repair alloys
  {
    type = "technology",
    name = "healing-alloys-1",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[1]*60*100), tostring(REPAIR_FACTORS[1]*100), tostring(REPAIR_LIMITS[1])},
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[1]*60*100), tostring(REPAIR_FACTORS[1]*100), tostring(REPAIR_LIMITS[1])},	
      }
    },
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
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"biter-flesh", 8}
      },
      time = 60
    },
    order = "a-f",
	icon_size = 128,
  },
    {
    type = "technology",
    name = "healing-alloys-2",
    icon = "__EndgameCombat__/graphics/technology/healalloy.png",
	--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[2]*60*100), tostring(REPAIR_FACTORS[2]*100), tostring(REPAIR_LIMITS[2])},
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[2]*60*100), tostring(REPAIR_FACTORS[2]*100), tostring(REPAIR_LIMITS[2])},	
      }
    },
    prerequisites =
    {
      "healing-alloys-1",
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
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
	--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[3]*60*100), tostring(REPAIR_FACTORS[3]*100), tostring(REPAIR_LIMITS[3])},
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[3]*60*100), tostring(REPAIR_FACTORS[3]*100), tostring(REPAIR_LIMITS[3])},	
      }
    },
    prerequisites =
    {
      "healing-alloys-2",
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
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
	--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[4]*60*100), tostring(REPAIR_FACTORS[4]*100), tostring(REPAIR_LIMITS[4])},
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[4]*60*100), tostring(REPAIR_FACTORS[4]*100), tostring(REPAIR_LIMITS[4])},	
      }
    },
    prerequisites =
    {
      "healing-alloys-3",
    },
    unit =
    {
      count = 800,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
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
	--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[5]*60*100), tostring(REPAIR_FACTORS[5]*100), tostring(REPAIR_LIMITS[5])},
    effects =
    {
      {
        type = "nothing",
        effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[5]*60*100), tostring(REPAIR_FACTORS[5]*100), tostring(REPAIR_LIMITS[5])},	
      }
    },
    prerequisites =
    {
      "healing-alloys-4",
    },
    unit =
    {
      count = 1600,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1},
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
		createShockwaveDmgUpgrade(1)
    },
    prerequisites = {"shockwave-turrets"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
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
		createShockwaveDmgUpgrade(2)
    },
    prerequisites = {"shockwave-turret-damage-1"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
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
		createShockwaveDmgUpgrade(3)
    },
    prerequisites = {"shockwave-turret-damage-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
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
		createShockwaveDmgUpgrade(4)
    },
    prerequisites = {"shockwave-turret-damage-3"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
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
		createShockwaveDmgUpgrade(5)
    },
    prerequisites = {"shockwave-turret-damage-4"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
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

for i = 1,5 do
data:extend({
    {
    type = "technology",
    name = "lightning-turret-charging-" .. i,
    icon = "__EndgameCombat__/graphics/technology/lightning-turret-charge-speed.png",
    prerequisites =
    {
	  i == 1 and "lightning-turrets" or ("lightning-turret-charging-" .. i-1),
    },
	effects =
	{
	  {
		type = "nothing",
		effect_description = {"modifier-description.lightning-turret-charging", tostring(LIGHTNING_TURRET_RECHARGE_TIME_REDUCTION_PER_TECH/60), tostring((LIGHTNING_TURRET_RECHARGE_TIME-LIGHTNING_TURRET_RECHARGE_TIME_REDUCTION_PER_TECH*i)/60)}
	  }
	},
    unit =
    {
      count = 400+(i-1)*100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 75
    },
    upgrade = true,
    order = "a-f",
	icon_size = 128,
  }
})
end

for i = 1,MAX_DOME_STRENGTH_TECH_LEVEL do
	local ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"military-science-pack", 1},
			{"utility-science-pack", 1},
	}
	if i > 4 then
		ingredients = {
			{"automation-science-pack", 4},
			{"logistic-science-pack", 4},
			{"chemical-science-pack", 4},
			{"military-science-pack", 4},
			{"utility-science-pack", 4},
			{"space-science-pack", 1}
		}
	end
		  
	data:extend({
	  {
		type = "technology",
		name = "shield-dome-strength-" .. i,
		icon = "__EndgameCombat__/graphics/technology/dome-strength.png",
		--localised_description = {"technology-description.shield-dome-strength", tostring(100*(getCurrentDomeStrengthFactorByLevel(i)-1))},
		effects =
		{
		  {
			type = "nothing",
			effect_description = {"modifier-description.shield-dome-strength", tostring(100*(getCurrentDomeStrengthFactorByLevel(i)-1)), tostring(100*(getTotalDomeStrengthFactorByLevel(i)-1))}
		  }
		},
		prerequisites = {i == 1 and "shield-domes" or "shield-dome-strength-" .. (i-1)},
		unit =
		{
		  count = i <= 4 and 250*i or 250*(i-4),
		  ingredients = ingredients,
		  time = 30
		},
		upgrade = true,
		order = "e-n-e",
		icon_size = 128,
	  },
	})
end

for i = 1,MAX_DOME_RECHARGE_TECH_LEVEL do
	local ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"military-science-pack", 1},
			{"utility-science-pack", 1},
	}
	if i > 10 then
		ingredients = {
			{"automation-science-pack", 4},
			{"logistic-science-pack", 4},
			{"chemical-science-pack", 4},
			{"military-science-pack", 4},
			{"utility-science-pack", 4},
			{"space-science-pack", 1}
		}
	end
		  
	data:extend({
	  {
		type = "technology",
		name = "shield-dome-recharge-" .. i,
		icon = "__EndgameCombat__/graphics/technology/dome-recharge.png",
		--localised_description = {"technology-description.shield-dome-recharge", tostring(100*(1/getCurrentDomeCostFactorByLevel(i)-1))},
		effects =
		{
		  {
			type = "nothing",
			effect_description = {"modifier-description.shield-dome-recharge", tostring(100*(1/getCurrentDomeCostFactorByLevel(i)-1)), tostring(100*math.floor((1/getTotalDomeCostFactorByLevel(i)-1)*10000+0.5)/10000)}
		  }
		},
		prerequisites = {i == 1 and "shield-domes" or "shield-dome-recharge-" .. (i-1)},
		unit =
		{
		  count = i <= 10 and 100*i or 250*(i-10),
		  ingredients = ingredients,
		  time = 30
		},
		upgrade = true,
		order = "e-n-e",
		icon_size = 128,
	  },
	})
end

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
		--localised_description = {"technology-description.healing-alloys", tostring(REPAIR_CHANCES[i]*60*100), tostring(REPAIR_FACTORS[i]*100), tostring(REPAIR_LIMITS[i])},
		effects =
		{
		  {
			type = "nothing",
			effect_description = {"modifier-description.healing-alloys", tostring(REPAIR_CHANCES[i]*60*100), tostring(REPAIR_FACTORS[i]*100), tostring(REPAIR_LIMITS[i])},	
		  }
		},
		prerequisites =
		{
		  "healing-alloys-" .. (i-1),
		},
		unit =
		{
		  count = math.ceil(1600*(1.5^(i-5))),
		  ingredients =
		  {
			{"automation-science-pack", 2},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"military-science-pack", 1},
			{"utility-science-pack", 1},
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
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1}
	}
	
	if l >= 3 then
		packs[#packs+1] = {"military-science-pack", 1}
	end	
	if l >= 5 then
		packs[#packs+1] = {"chemical-science-pack", 1}
	end	
	if l >= 7 then
		packs[#packs+1] = {"utility-science-pack", 1}
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
			--localised_description = {"technology-description.turret-range", tostring(TURRET_RANGE_BOOSTS[l]), tostring(TURRET_RANGE_BOOST_SUMS[l])},
			effects =
			{
			  {
				type = "nothing",
				effect_description = {"modifier-description.turret-range", tostring(TURRET_RANGE_BOOSTS[l]), tostring(TURRET_RANGE_BOOST_SUMS[l])},	
			  }
			},
			prerequisites = prereq,
			unit =
			{
			  count = math.ceil(50*(2^(l-1))),
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

local function make_modifier_icon(name)
  return
  {
    filename = "__EndgameCombat__/graphics/icons/" .. name .. ".png",
    priority = "medium",
    width = 32,
    height = 32,
    flags = {"icon"}
  }
end

data.raw["utility-sprites"]["default"].turret_range_modifier_icon = make_modifier_icon("turret-range-modifier")
