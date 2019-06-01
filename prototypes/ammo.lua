data:extend(
{
  {
    type = "ammo",
    name = "sulfur-bullet-magazine",
    icon = "__EndgameCombat__/graphics/icons/sulfur-bullet-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 5 , type = "physical"}
            },
			{
              type = "damage",
              damage = { amount = 5 , type = "fire"}
            }
          }
        }
      }
    },
    magazine_size = 10,
	subgroup = "ammo",
    order = "a",
    stack_size = 200
  },
  {
    type = "fluid",
    name = "sticky",
    default_temperature = 15,
    max_temperature = 30,
    heat_capacity = "0.04KJ",
    base_color = {r=178/255, g=160/255, b=105/255},
    flow_color = {r=229/255, g=227/255, b=213/255},
    icon = "__EndgameCombat__/graphics/icons/sticky.png",
    icon_size = 32,
    order = "a[fluid]-a[sticky]",
    pressure_to_speed_ratio = 0.1,
    flow_to_energy_ratio = 0.59
  },
  {
    type = "ammo",
    name = "supercavitating-bullet-magazine",
    icon = "__EndgameCombat__/graphics/icons/explosive-bullet-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 14 , type = "cavitation"}
            },
          }
        }
      }
    },
    magazine_size = 10,
	subgroup = "ammo",
    order = "a",
    stack_size = 200
  },
    {
    type = "ammo",
    name = "sulfur-heavy-bullet-magazine",
    icon = "__EndgameCombat__/graphics/icons/sulfur-heavy-bullet-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
              type = "create-entity",
              entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-gunshot"
            },
            {
              type = "damage",
              damage = { amount = 18 , type = "physical"}
            },
			{
              type = "damage",
              damage = { amount = 9 , type = "fire"}
            }
          }
        }
      }
    },
    magazine_size = 10,
	subgroup = "ammo",
    order = "a",
    stack_size = 200
  },
  
    {
    type = "ammo",
    name = "hiex-cannon-shell-big",
    icon = "__EndgameCombat__/graphics/icons/cannon-shell-hiex.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "hiex-cannon-projectile-big",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 70
        }
      },
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-a[basic]",
    stack_size = 100
  },--[[
    {
    type = "ammo",
    name = "nuke-shell",
    icon = "__EndgameCombat__/graphics/icons/nuke-shell.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "nuke-projectile",
          starting_speed = 0.25,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 200
        }
      },
    },
    subgroup = "ammo",
    order = "c",
    stack_size = 100
  },--]]
      {
    type = "ammo",
    name = "neutron-shell",
    icon = "__EndgameCombat__/graphics/icons/neutron-shell.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "neutron-projectile",
          starting_speed = 0.25,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 200
        }
      },
    },
    subgroup = "ammo",
    order = "c",
    stack_size = 100
  },
        {
    type = "ammo",
    name = "neutron-rocket",
    icon = "__EndgameCombat__/graphics/icons/neutron-rocket.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      range_modifier = 3,
      cooldown_modifier = 3,
      target_type = "position",
      category = "rocket",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "neutron-projectile",
          starting_speed = 0.25,
        }
      },
    },
    subgroup = "ammo",
    order = "c",
    stack_size = 100
  },
        {
    type = "ammo",
    name = "napalm-shell",
    icon = "__EndgameCombat__/graphics/icons/napalm-shell.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "napalm-projectile",
          starting_speed = 0.25,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 120
        }
      },
    },
    subgroup = "ammo",
    order = "c",
    stack_size = 100
  },
          {
    type = "ammo",
    name = "napalm-rocket",
    icon = "__EndgameCombat__/graphics/icons/napalm-rocket.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      range_modifier = 2,
      cooldown_modifier = 2,
      target_type = "position",
      category = "rocket",
      source_effects =
      {
        type = "create-entity",
        entity_name = "explosion-gunshot"
      },
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          starting_speed = 0.25,
          projectile = "napalm-projectile",
        }
      },
    },
    subgroup = "ammo",
    order = "c",
    stack_size = 100
  },
  
    {
    type = "capsule",
    name = "radiation-capsule",
    icon = "__EndgameCombat__/graphics/icons/radiation-capsule.png",
	icon_size = 32,
    flags = {},
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 20,
        projectile_creation_distance = 0.6,
        range = 40,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "projectile",
              projectile = "radiation-capsule",
              starting_speed = 0.3
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "b[radiation-capsule]",
    stack_size = 100
   },
   
       {
    type = "capsule",
    name = "acid-capsule",
    icon = "__EndgameCombat__/graphics/icons/acid-capsule.png",
	icon_size = 32,
    flags = {},
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 20,
        projectile_creation_distance = 0.6,
        range = 30,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "projectile",
              projectile = "acid-capsule",
              starting_speed = 0.3
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "b[acid-capsule]",
    stack_size = 100
   },
}
)

