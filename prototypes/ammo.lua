data:extend(
{
  {
    type = "ammo",
    name = "sulfur-bullet-magazine",
    icon = "__EndgameCombat__/graphics/icons/sulfur-bullet-magazine.png",
    flags = {"goes-to-main-inventory"},
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
              damage = { amount = 8 , type = "physical"}
            },
			{
              type = "damage",
              damage = { amount = 8 , type = "fire"}
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
    name = "sulfur-heavy-bullet-magazine",
    icon = "__EndgameCombat__/graphics/icons/sulfur-heavy-bullet-magazine.png",
    flags = {"goes-to-main-inventory"},
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
              damage = { amount = 24 , type = "physical"}
            },
			{
              type = "damage",
              damage = { amount = 10 , type = "impact"}
            },
			{
              type = "damage",
              damage = { amount = 16 , type = "fire"}
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-main-inventory"},
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
    flags = {"goes-to-quickbar"},
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
    flags = {"goes-to-quickbar"},
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

