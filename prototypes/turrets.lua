require "constants"

function cannon_turret_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__EndgameCombat__/graphics/entity/cannon-turret-sheet.png",
      priority = "medium",
      scale = 0.75,
      width = 128,
      height = 128,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 8,
      axially_symmetrical = false,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
    shift = { 0.35, -0.5 },
    }
  }
}
end

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
  },
    {
    type = "item",
    name = "shockwave-turret",
    icon = "__EndgameCombat__/graphics/icons/shockwave-turret.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[shockwave-turret-1-2]",
    place_result = "shockwave-turret",
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
      range = 22,
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
    minable = {mining_time = 1, result = "cannon-turret"},
    max_health = 1500,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.003,
    preparing_speed = 0.04,
    folding_speed = 0.04,
    dying_explosion = "medium-explosion",
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    
    folded_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    preparing_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    prepared_animation = cannon_turret_sheet{},
    attacking_animation = cannon_turret_sheet{},
    folding_animation = cannon_turret_sheet{direction_count = 8, line_length = 1, run_mode = "backward"},
    
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell-magazine",
      cooldown = 180,
      projectile_creation_distance = 1.75,
      projectile_center = {0, 0},
      damage_modifier = 1,
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
      range = 35,
      min_range = 12,
      sound =
      {
        {
            filename = "__base__/sound/fight/tank-cannon.ogg",
            volume = 1.0
        }
      },
    },
    call_for_help_radius = 46
  },
}
)

local function createEmptyAnimation()
	local ret = {
		filename = "__EndgameCombat__/graphics/entity/shockwave-turret-trans.png",
        line_length = 1,
		width = 258,
		height = 186,
        frame_count = 1,
        axially_symmetrical = false,
        direction_count = 1,
        draw_as_shadow = false,
        --shift = {1.5, 0}
	}
	
	return ret
end

data:extend(
{
  {
    type = "electric-turret",
    name = "shockwave-turret",
    render_layer = "object",
    icon = "__EndgameCombat__/graphics/icons/shockwave-turret.png",
    flags = {"placeable-player", "placeable-neutral", "player-creation"},
    order = "s-e-w-f",
    minable = {mining_time = 1, result = "shockwave-turret"},
    max_health = 500,
    corpse = "big-remnants",
	dying_explosion = "medium-explosion",
    collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
	folding_animation = createEmptyAnimation(),
	folded_animation = createEmptyAnimation(),
	prepared_animation = createEmptyAnimation(),
	preparing_animation = createEmptyAnimation(),
    base_picture =
    {
      filename = "__EndgameCombat__/graphics/entity/shockwave.png",
      priority = "extra-high",
      width = 258,
      height = 186,
	  scale = 0.5,
      shift = {0.6, 0},
      frame_count = 1,
    },
	call_for_help_radius = SHOCKWAVE_TURRET_RADIUS,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "1MJ",
      input_flow_limit = "2400kW",
      drain = "10kW",
      usage_priority = "primary-input"
    },
	attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 20,
      projectile_center = {-0.09375, -0.2},
      projectile_creation_distance = 1.4,
      range = SHOCKWAVE_TURRET_RADIUS,
      damage_modifier = 0,
      ammo_type =
      {
        type = "projectile",
        category = "shockwave-turret",
        energy_consumption = "0kJ",
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
				projectile = "shockwave-dummy-projectile",
                starting_speed = 100
            }
          }
        }
      },
      sound = nil
    },
  },
})

data:extend({
  {
    type = "explosion",
    name = "shockwave-turret-effect",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__EndgameCombat__/graphics/entity/shockwave-effect.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 197,
        height = 245,
        frame_count = 47,
        line_length = 6,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {0.1875, -0.75},
		scale = 1.0,
        animation_speed = 1,--0.5,
		blend_mode = "additive",
      }
    },
    light = {intensity = 1, size = 50, color = {r=0.72, g=1.0, b=1.0}},
    sound =
    {
      aggregation =
      {
        max_count = 1,
        remove = true
      },
      variations =
      {
        {
          filename = "__EndgameCombat__/sounds/shockwave-turret.ogg",
          volume = 0.8
        },
      }
    },
    created_effect = nil,--[[
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 20,
            entity_name = "explosion-remnants-particle",
            initial_height = 0.5,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.15,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.15,
            offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
          }
        }
      }
    }--]]
  },
  {
      type = "explosion",
      name = "shockwave-beam",
      flags = {"not-on-map", "placeable-off-grid"},
      animation_speed = 1,
      rotate = true,
      beam = true,
      animations =
      {
        {
        filename = "__EndgameCombat__/graphics/entity/shockwave-beam.png",
        priority = "extra-high",
        width = 10,
        height = 180,
        frame_count = 6,
		blend_mode = "additive",
        }
      },
      light = {intensity = 0.1, size = 2},
      smoke = "smoke-fast",
      smoke_count = 1,
      smoke_slow_down_factor = 1
    },
	  {
    type = "projectile",
    name = "shockwave-dummy-projectile",
    flags = {"not-on-map"},
    acceleration = 0,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = { amount = 0, type = "laser"}
          }
        }
      }
    },
    light = nil,--{intensity = 0.5, size = 10},
    animation =
    {
      filename = "__EndgameCombat__/graphics/entity/dummy-projectile.png",
      tint = {r=1.0, g=1.0, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    },
    speed = 0
  }
})