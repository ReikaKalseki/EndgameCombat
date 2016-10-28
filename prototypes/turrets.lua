data:extend(
{
  {
    type = "item",
    name = "concussion-turret",
    icon = "__EndgameCombat__/graphics/icons/gun-turret.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[concussion-turret-1-2]",
    place_result = "concussion-turret",
    stack_size = 50
  },
    {
    type = "item",
    name = "plasma-turret",
    icon = "__EndgameCombat__/graphics/icons/laser-turret.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[laser-turret]-f[plasma-turret-1-2]",
    place_result = "plasma-turret",
    stack_size = 50
  },
    {
    type = "item",
    name = "cannon-turret",
    icon = "__EndgameCombat__/graphics/icons/cannon-turret.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[cannon-turret-1-2]",
    place_result = "cannon-turret",
    stack_size = 50
  }
}
)

data:extend(
{
{
    type = "ammo-turret",
    name = "concussion-turret",
    icon = "__EndgameCombat__/graphics/icons/gun-turret.png",
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "concussion-turret"},
    max_health = 2000,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.015,
    preparing_speed = 0.08,
    folding_speed = 0.08,
	fast_replaceable_group =  "gun-turret",
    dying_explosion = "medium-explosion",
    inventory_size = 2,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    call_for_help_radius = 50,
    resistances =
    {
      {
        type = "physical",
        decrease = 0,
        percent = 10
      },
      {
        type = "acid",
        decrease = 0,
        percent = 10
      },
    },
    folded_animation = 
    {
      layers =
      {
        gun_turret_extension{frame_count=1, line_length = 1},
        gun_turret_extension_mask{frame_count=1, line_length = 1},
        gun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation = 
    {
      layers =
      {
        gun_turret_extension{},
        gun_turret_extension_mask{},
        gun_turret_extension_shadow{}
      }
    },
    prepared_animation = gun_turret_attack{frame_count=1},
    attacking_animation = gun_turret_attack{},
    folding_animation = 
    { 
      layers = 
      { 
        gun_turret_extension{run_mode = "backward"},
        gun_turret_extension_mask{run_mode = "backward"},
        gun_turret_extension_shadow{run_mode = "backward"}
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/gun-turret/gun-turret-base.png",
          priority = "high",
          width = 90,
          height = 75,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
          shift = {0.0625, -0.046875},
        },
        {
          filename = "__EndgameCombat__/graphics/entity/gun-turret/gun-turret-base-mask.png",
          line_length = 1,
          width = 52,
          height = 47,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = {0.0625, -0.234375},
          apply_runtime_tint = true
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 6,
      projectile_creation_distance = 1.39375,
      projectile_center = {0.0625, -0.0875}, -- same as gun_turret_attack shift
      damage_modifier = 5, --more DPS than plasma turret, but physical (and thus resisted against), so balanced
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = 27.5,
      sound = make_heavy_gunshot_sounds(),
    }
  },
  {
    type = "electric-turret",
    name = "plasma-turret",
    icon = "__EndgameCombat__/graphics/icons/laser-turret.png",
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    minable = { mining_time = 0.5, result = "plasma-turret" },
    max_health = 2000,
    corpse = "medium-remnants",
    collision_box = {{ -0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{ -1, -1}, {1, 1}},
    rotation_speed = 0.01,
    preparing_speed = 0.05,
	fast_replaceable_group =  "laser-turret",
    dying_explosion = "medium-explosion",
    folding_speed = 0.05,
    call_for_help_radius = 60,
    resistances =
    {
      {
        type = "physical",
        decrease = 0,
        percent = 10
      },
      {
        type = "acid",
        decrease = 0,
        percent = 10
      },
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "1.2MJ",
      input_flow_limit = "7200kW",
      drain = "80kW",
      usage_priority = "primary-input"
    },
    folded_animation =
    {
      layers =
      {
        laser_turret_extension{frame_count=1, line_length = 1},
        laser_turret_extension_shadow{frame_count=1, line_length=1},
        laser_turret_extension_mask{frame_count=1, line_length=1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        laser_turret_extension{},
        laser_turret_extension_shadow{},
        laser_turret_extension_mask{}
      }
    },
    prepared_animation =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun.png",
          line_length = 8,
          width = 68,
          height = 68,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {0.0625, -1}
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun-mask.png",
          line_length = 8,
          width = 54,
          height = 44,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 64,
          shift = {0.0625, -1.3125},
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun-shadow.png",
          line_length = 8,
          width = 88,
          height = 52,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          draw_as_shadow = true,
          shift = {1.59375, 0}
        }
      }
    },
    folding_animation = 
    {
      layers =
      {
        laser_turret_extension{run_mode = "backward"},
        laser_turret_extension_shadow{run_mode = "backward"},
        laser_turret_extension_mask{run_mode = "backward"}
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-base.png",
          priority = "high",
          width = 98,
          height = 82,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
          shift = { 0.109375, 0.03125 }
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-base-mask.png",
          line_length = 1,
          width = 54,
          height = 46,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 1,
          shift = {0.046875, -0.109375},
        },
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 12,
      projectile_center = {0, -0.2},
      projectile_creation_distance = 1.4,
      range = 30,
      damage_modifier = 5,
      ammo_type =
      {
        type = "projectile",
        category = "plasma-turret",
        energy_consumption = "600kJ",
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "plasma-laser",
                starting_speed = 0.28
              }
            }
          }
        }
      },
      sound = { filename = "__EndgameCombat__/sounds/plasmashot.ogg", volume = 0.75 },
    }
  },
  
  {
    type = "ammo-turret",
    name = "cannon-turret",
    icon = "__EndgameCombat__/graphics/icons/cannon-turret.png",
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "cannon-turret"},
    max_health = 7500,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.015,
    preparing_speed = 0.08,
    folding_speed = 0.08,
	fast_replaceable_group =  "cannon-turret",
    dying_explosion = "massive-explosion",
    inventory_size = 2,
    automated_ammo_count = 10,
    attacking_speed = 0.25,
    call_for_help_radius = 80,
    resistances =
    {
      {
        type = "physical",
        decrease = 0,
        percent = 10
      },
      {
        type = "acid",
        decrease = 0,
        percent = 10
      },
    },
    folded_animation = 
    {
      layers =
      {
        gun_turret_extension{frame_count=1, line_length = 1},
        gun_turret_extension_mask{frame_count=1, line_length = 1},
        gun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation = 
    {
      layers =
      {
        gun_turret_extension{},
        gun_turret_extension_mask{},
        gun_turret_extension_shadow{}
      }
    },
    prepared_animation = gun_turret_attack{frame_count=1},
    attacking_animation = gun_turret_attack{},
    folding_animation = 
    { 
      layers = 
      { 
        gun_turret_extension{run_mode = "backward"},
        gun_turret_extension_mask{run_mode = "backward"},
        gun_turret_extension_shadow{run_mode = "backward"}
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/cannon-turret/gun-turret-base.png",
          priority = "high",
          width = 90,
          height = 75,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
          shift = {0.0625, -0.046875},
        },
        {
          filename = "__EndgameCombat__/graphics/entity/cannon-turret/gun-turret-base-mask.png",
          line_length = 1,
          width = 52,
          height = 47,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = {0.0625, -0.234375},
          apply_runtime_tint = true
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell",
      cooldown = 150,
      projectile_creation_distance = 1.39375,
      projectile_center = {0.0625, -0.0875}, -- same as gun_turret_attack shift
      damage_modifier = 1,
	  --[[
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
	  --]]
	  
	  --[[
	    ammo_type.action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "uranium-cannon-projectile",
                starting_speed = 0.28
              }
            }
          }
        },
	  --]]
	  --[[
	  ammo_type =
      {
        type = "projectile",
        category = "cannon-shell",
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "uranium-cannon-projectile",
                starting_speed = 0.28
              }
            }
          }
        }
      },
	  --]]
	  
      range = 75,
      sound = make_heavy_gunshot_sounds(),
    }
  },
}
)