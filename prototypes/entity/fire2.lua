require "util"
require "firefunc"

local math3d = require "math3d"

local fire2_damage_per_tick = 1--45 / 60
local flamethrower2_stream_on_hit_damage = 1.5--1
local new_burn_factor = 2

data:extend({
{
  type = "fire",
  name = "big-fire-flame",
  flags = {"placeable-off-grid", "not-on-map"},
  duration = 600*new_burn_factor,
  fade_away_duration = 600*new_burn_factor,
  spread_duration = 600,
  start_scale = 0.20,
  end_scale = 1.0,
  color = {r=1, g=0.9, b=0.3, a=0.65},
  damage_per_tick = {amount = fire2_damage_per_tick, type = "fire"},
  
  spawn_entity = "fire-flame-on-tree",
  
  spread_delay = 300,
  spread_delay_deviation = 180,
  maximum_spread_count = 100,
  initial_lifetime = 480*new_burn_factor,
  
  flame_alpha = 0.35,
  flame_alpha_deviation = 0.05,
  
  emissions_per_tick = 0.005,
  
  add_fuel_cooldown = 10,
  increase_duration_cooldown = 10,
  increase_duration_by = 20,
  fade_in_duration = 30,
  fade_out_duration = 30,
  
  lifetime_increase_by = 20,
  lifetime_increase_cooldown = 10,
  delay_between_initial_flames = 10,
  burnt_patch_lifetime = 1800*new_burn_factor,
  
  on_fuel_added_action =
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "create-trivial-smoke",
          smoke_name = "fire-smoke-on-adding-fuel",
          -- speed = {-0.03, 0},
          -- speed_multiplier = 0.99,
          -- speed_multiplier_deviation = 1.1,
          offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
          speed_from_center = 0.01
        }
      }
    }
  },
  
  pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.5}),
  
  smoke_source_pictures = 
  {
    { 
      filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
      line_length = 8,
      width = 101,
      height = 138,
      frame_count = 31,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {-0.109375, -1.1875},
      animation_speed = 0.5,
    },
    { 
      filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
      line_length = 8,
      width = 99,
      height = 138,
      frame_count = 31,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {-0.203125, -1.21875},
      animation_speed = 0.5,
    },
  },
  
  burnt_patch_pictures = fireutil.create_burnt_patch_pictures(),
  burnt_patch_alpha_default = 0.4,
  burnt_patch_alpha_variations = {
    -- { tile = "grass-1", alpha = 0.45 },
    -- { tile = "grass-2", alpha = 0.45 },
    -- { tile = "grass-3", alpha = 0.45 },
    -- { tile = "grass-4", alpha = 0.45 },
    -- { tile = "dry-dirt", alpha = 0.3 },
    -- { tile = "dirt-1", alpha = 0.3 },
    -- { tile = "dirt-2", alpha = 0.3 },
    -- { tile = "dirt-3", alpha = 0.3 },
    -- { tile = "dirt-4", alpha = 0.3 },
    -- { tile = "dirt-5", alpha = 0.3 },
    -- { tile = "dirt-6", alpha = 0.3 },
    -- { tile = "dirt-7", alpha = 0.3 },
    -- { tile = "sand-1", alpha = 0.24 },
    -- { tile = "sand-2", alpha = 0.24 },
    -- { tile = "sand-3", alpha = 0.24 },
    -- { tile = "red-desert-0", alpha = 0.28 },
    -- { tile = "red-desert-1", alpha = 0.28 },
    -- { tile = "red-desert-2", alpha = 0.28 },
    -- { tile = "red-desert-3", alpha = 0.28 },
    { tile = "stone-path", alpha = 0.26 },
    { tile = "concrete", alpha = 0.24 },
  },

  smoke =
  {
    {
      name = "fire-smoke",
      deviation = {0.5, 0.5},
      frequency = 0.25 / 2,
      position = {0.0, -0.8},
      starting_vertical_speed = 0.05,
      starting_vertical_speed_deviation = 0.005,
      vertical_speed_slowdown = 0.99,
      starting_frame_deviation = 60,
      height = -0.5,
    }
  },
 
  light = {intensity = 1, size = 20},
  
  working_sound =
  {
    sound = { filename = "__base__/sound/furnace.ogg" },
    max_sounds_per_type = 3
  },	
 
},
{
  type = "fire",
  name = "big-fire-flame-napalm", --like big-fire-flame but lasts 5x longer
  flags = {"placeable-off-grid", "not-on-map"},
  duration = 600*new_burn_factor*5,
  fade_away_duration = 600*new_burn_factor,
  spread_duration = 600,
  start_scale = 0.20,
  end_scale = 1.0,
  color = {r=1, g=0.9, b=0.3, a=0.65},
  damage_per_tick = {amount = fire2_damage_per_tick, type = "fire"},
  
  spawn_entity = "fire-flame-on-tree",
  
  spread_delay = 300,
  spread_delay_deviation = 180,
  maximum_spread_count = 100,
  initial_lifetime = 480*new_burn_factor*5,
  
  flame_alpha = 0.35,
  flame_alpha_deviation = 0.05,
  
  emissions_per_tick = 0.025,
  
  add_fuel_cooldown = 10,
  increase_duration_cooldown = 10,
  increase_duration_by = 20,
  fade_in_duration = 30,
  fade_out_duration = 30,
  
  lifetime_increase_by = 20,
  lifetime_increase_cooldown = 10,
  delay_between_initial_flames = 10,
  burnt_patch_lifetime = 1800*new_burn_factor,
  
  on_fuel_added_action =
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "create-trivial-smoke",
          smoke_name = "fire-smoke-on-adding-fuel",
          -- speed = {-0.03, 0},
          -- speed_multiplier = 0.99,
          -- speed_multiplier_deviation = 1.1,
          offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
          speed_from_center = 0.01
        }
      }
    }
  },
  
  pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.5}),
  
  smoke_source_pictures = 
  {
    { 
      filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
      line_length = 8,
      width = 101,
      height = 138,
      frame_count = 31,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {-0.109375, -1.1875},
      animation_speed = 0.5,
    },
    { 
      filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
      line_length = 8,
      width = 99,
      height = 138,
      frame_count = 31,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {-0.203125, -1.21875},
      animation_speed = 0.5,
    },
  },
  
  burnt_patch_pictures = fireutil.create_burnt_patch_pictures(),
  burnt_patch_alpha_default = 0.4,
  burnt_patch_alpha_variations = {
    -- { tile = "grass-1", alpha = 0.45 },
    -- { tile = "grass-2", alpha = 0.45 },
    -- { tile = "grass-3", alpha = 0.45 },
    -- { tile = "grass-4", alpha = 0.45 },
    -- { tile = "dry-dirt", alpha = 0.3 },
    -- { tile = "dirt-1", alpha = 0.3 },
    -- { tile = "dirt-2", alpha = 0.3 },
    -- { tile = "dirt-3", alpha = 0.3 },
    -- { tile = "dirt-4", alpha = 0.3 },
    -- { tile = "dirt-5", alpha = 0.3 },
    -- { tile = "dirt-6", alpha = 0.3 },
    -- { tile = "dirt-7", alpha = 0.3 },
    -- { tile = "sand-1", alpha = 0.24 },
    -- { tile = "sand-2", alpha = 0.24 },
    -- { tile = "sand-3", alpha = 0.24 },
    -- { tile = "red-desert-0", alpha = 0.28 },
    -- { tile = "red-desert-1", alpha = 0.28 },
    -- { tile = "red-desert-2", alpha = 0.28 },
    -- { tile = "red-desert-3", alpha = 0.28 },
    { tile = "stone-path", alpha = 0.26 },
    { tile = "concrete", alpha = 0.24 },
  },

  smoke =
  {
    {
      name = "fire-smoke",
      deviation = {0.5, 0.5},
      frequency = 0.25 / 2,
      position = {0.0, -0.8},
      starting_vertical_speed = 0.05,
      starting_vertical_speed_deviation = 0.005,
      vertical_speed_slowdown = 0.99,
      starting_frame_deviation = 60,
      height = -0.5,
    }
  },
 
  light = {intensity = 1, size = 20},
  
  working_sound =
  {
    sound = { filename = "__base__/sound/furnace.ogg" },
    max_sounds_per_type = 3
  },	
 
},
})
--[[
data:extend(
{
  {
    type = "stream",
    name = "flamethrower-fire-stream",
    flags = {"not-on-map"},
    stream_light = {intensity = 1, size = 4},
    ground_light = {intensity = 0.8, size = 4},
  
    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.05, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60
      }
    },
    particle_buffer_size = 90,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 8,
    particle_vertical_acceleration = 0.005 * 0.60,
    particle_horizontal_speed = 0.2* 0.75 * 1.5,
    particle_horizontal_speed_deviation = 0.005 * 0.70,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "fire-flame"
            }
          }
        }
      },
      {
        type = "area",
        radius = 2.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "fire-sticker"
            },
            {
              type = "damage",
              damage = { amount = flamethrower2_stream_on_hit_damage, type = "fire" }
            }
          }
        }
      }
    },
    
    spine_animation = 
    { 
      filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
      blend_mode = "additive",
      --tint = {r=1, g=1, b=1, a=0.5},
      line_length = 4,
      width = 32,
      height = 18,
      frame_count = 32,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 2,
      shift = {0, 0},
    },
    
    shadow =
    {
      filename = "__base__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
      line_length = 5,
      width = 28,
      height = 16,
      frame_count = 33,
      priority = "high",
      shift = {-0.09, 0.395}
    },
    
    particle =
    {
      filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      frame_count = 32,
      line_length = 8
    },
  }
}
)--]]

data:extend(
{
  {
    type = "stream",
    name = "handheld-flamethrower-fire-stream",
    flags = {"not-on-map"},
    working_sound_disabled =
    {
      {
        filename = "__base__/sound/fight/electric-beam.ogg",
        volume = 0.7
      }
    },
    
    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.05, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60
      }
    },
  
    stream_light = {intensity = 1, size = 4 * 0.8},
    ground_light = {intensity = 0.8, size = 4 * 0.8},
  
    particle_buffer_size = 65,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 2,
    particle_vertical_acceleration = 0.005 * 0.6,
    particle_horizontal_speed = 0.25,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "big-fire-flame"
            },
            {
              type = "damage",
              damage = { amount = flamethrower2_stream_on_hit_damage, type = "fire" }
            }
          }
        }
      },
      {
        type = "area",
        radius = 3.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "fire-sticker"
            }
          }
        }
      }
    },
    
    spine_animation = 
    { 
      filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
      blend_mode = "additive",
      --tint = {r=1, g=1, b=1, a=0.5},
      line_length = 4,
      width = 32,
      height = 18,
      frame_count = 32,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 2,
      scale = 0.75,
      shift = {0, 0},
    },
    
    shadow =
    {
      filename = "__base__/graphics/entity/acid-projectile-purple/acid-projectile-purple-shadow.png",
      line_length = 5,
      width = 28,
      height = 16,
      frame_count = 33,
      priority = "high",
      scale = 0.5,
      shift = {-0.09 * 0.5, 0.395 * 0.5}
    },
    
    particle =
    {
      filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      frame_count = 32,
      line_length = 8,
      scale = 0.8,
    },
  }
}
)
