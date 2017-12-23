require "util"

require "radiationfirefunc"

require "config"
require "constants"

local math3d = require "math3d"

for lifevar = RADIATION_LIFE_VAR_MIN,RADIATION_LIFE_VAR_MAX,RADIATION_LIFE_VAR_STEP do
	data:extend({
	{
	  type = "fire",
	  name = "radiation-fire-" .. lifevar,
	  flags = {"placeable-off-grid", "not-on-map"},
	  duration = 60*Config.radiationTimer*2+lifevar*2,
	  fade_away_duration = 60*Config.radiationTimer+lifevar,
	  spread_duration = 600,
	  start_scale = 1.0,
	  end_scale = 1.0,
	  color = {r=0.4, g=1, b=0.3, a=0.25},
	  damage_per_tick = {amount = 10, type = "radiation"},
	  
	  spawn_entity = "radiation-on-tree",
	  
	  spread_delay = 300,
	  spread_delay_deviation = 180,
	  maximum_spread_count = 0,--100,
	  initial_lifetime = 60*Config.radiationTimer+lifevar,
	  
	  flame_alpha = 0.125,
	  flame_alpha_deviation = 0.0625,
	  
	  emissions_per_tick = 0,--0.005,
	  
	  add_fuel_cooldown = 100000,--10,
	  increase_duration_cooldown = 10,
	  increase_duration_by = 20,
	  fade_in_duration = 30,
	  fade_out_duration = 30,
	  
	  lifetime_increase_by = 20,
	  lifetime_increase_cooldown = 10,
	  delay_between_initial_flames = 10,
	  burnt_patch_lifetime = 0,
	  
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
	  
	  pictures = radiationfireutil.create_fire_pictures({ blend_mode = "additive", animation_speed = 0.0625-0.02*lifevar/60, scale = 2.0}), --scale was 0.5
	  
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
	  
	  burnt_patch_pictures = radiationfireutil.create_burnt_patch_pictures(),
	  burnt_patch_alpha_default = 0.0,
	  burnt_patch_alpha_variations = {},

	  smoke = nil,--[[
	  {
		{
		  name = "fire-smoke",
		  deviation = {0.5, 0.5},
		  frequency = 0,--0.25 / 2,
		  position = {0.0, -0.8},
		  starting_vertical_speed = 0.05,
		  starting_vertical_speed_deviation = 0.005,
		  vertical_speed_slowdown = 0.99,
		  starting_frame_deviation = 60,
		  height = -0.5,
		}
	  },--]]
	 
	  light = {intensity = 1, size = 20, color={r=0, g=1, b=0}},
	  
	  working_sound =
	  {
		sound = { filename = "__EndgameCombat__/sounds/radiation.ogg" },
		max_sounds_per_type = 1
	  },	
	 
	}
	})
end

data:extend({
{
  type = "fire",
  name = "radiation-on-tree",
  flags = {"placeable-off-grid", "not-on-map"},

  damage_per_tick = {amount = 0, type = "radiation"},
  
  spawn_entity = "radiation-on-tree",
  maximum_spread_count = 0,
  
  spread_delay = 100000,
  spread_delay_deviation = 180,
  flame_alpha = 0.0,
  flame_alpha_deviation = 0.05,
  
  tree_dying_factor = 0.0,
  emissions_per_tick = 0,
  
  fade_in_duration = 1,
  fade_out_duration = 1,
  smoke_fade_in_duration = 100,
  smoke_fade_out_duration = 130,
  delay_between_initial_flames = 2000,
  
  small_tree_fire_pictures = radiationfireutil.create_small_tree_flame_animations({ blend_mode = "additive", animation_speed = 0.5, scale = 0.7 * 0.75 }),
  
  pictures = radiationfireutil.create_fire_pictures({ blend_mode = "additive", animation_speed = 1, scale = 0.5 * 1.25}),
  
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
      scale = 0.6,
      shift = {-0.109375 * 0.6, -1.1875 * 0.6},
      animation_speed = 0.5,
      tint = make_color(1,1,1, 0.75),
    },
    { 
      filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
      line_length = 8,
      width = 99,
      height = 138,
      frame_count = 31,
      axially_symmetrical = false,
      direction_count = 1,
      scale = 0.6,
      shift = {-0.203125 * 0.6, -1.21875 * 0.6},
      animation_speed = 0.5,
      tint = make_color(1,1,1, 0.75),
    },
  },
  
  smoke = nil,--[[
  {
    {
      name = "fire-smoke-without-glow",
      deviation = {0.5, 0.5},
      frequency = 0.25 / 2,
      position = {0.0, -0.8},
      starting_vertical_speed = 0.008,
      starting_vertical_speed_deviation = 0.05,
      starting_frame_deviation = 60,
      height = -0.5,
    }
  },--]]
   
  light = nil,--{intensity = 1, size = 20},

  working_sound =
  {
    sound = { filename = "__EndgameCombat__/sounds/radiation.ogg" },
    max_sounds_per_type = 3
  },	
}})