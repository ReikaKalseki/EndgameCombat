require "config"
require "functions"

data:extend({
	{
		type = "logistic-container",
		name = "turret-logistic-interface",
		icon = "__EndgameCombat__/graphics/icons/turret-logistic-chest.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation", "not-on-map", "placeable-off-grid", "not-blueprintable", "not-deconstructable"},
		--minable = {hardness = 0.4, mining_time = 0.75, result = ""},
		max_health = 100,
		corpse = "small-remnants",
		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		order = "z",
		resistances =
		{
		  {
			type = "fire",
			percent = 40
		  },
		},
		fast_replaceable_group = "container",
		inventory_size = 1,
		logistic_slots_count = 1,
		logistic_mode = "requester",
		render_not_in_network_icon = false,
		open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
		close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		picture =
		{
		  filename = "__EndgameCombat__/graphics/entity/turret-logistic-chest.png",
		  priority = "extra-high",
		  width = 38,
		  height = 32,
		  shift = {0.09375, 0}
		},
		circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
		circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
		circuit_wire_max_distance = 12,
	},
	{
		type = "item",
		name = "guard-tower",
		icon = "__EndgameCombat__/graphics/icons/tower.png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "defensive-structure",
		order = "guard-tower",
		place_result = "guard-tower",	
		stack_size = 1
	},
	{
		type = "car",
		name = "guard-tower",
		icon = "__EndgameCombat__/graphics/icons/tower.png",
		icon_size = 32,
		flags = {"placeable-neutral", "player-creation"},
		minable = {mining_time = 1.5, result = "guard-tower"},
		mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
		max_health = 1500,
		corpse = "big-remnants",
		energy_per_hit_point = 1,
		crash_trigger = crash_trigger(),
		resistances =
		{
		  {
			type = "fire",
			percent = 90
		  },
		  {
			type = "impact",
			percent = 40,
			decrease = 60
		  },
		  {
			type = "electric",
			percent = 100
		  },
		},
		collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
		selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
		effectivity = 0.0,
		braking_power = "0.1W",
		burner =
		{
		  fuel_category = "chemical",
		  effectivity = 10e-20,
		  fuel_inventory_size = 0,
		  smoke = nil,
		  render_no_power_icon = false,
		},
		consumption = "0kW",
		friction = 2e3,
		light = nil,
		render_layer = "object",
		animation =
		{
		  layers =
		  {
			{
			  priority = "low",
			  width = 220,
			  height = 370,
			  frame_count = 1,
			  direction_count = 1,
			  scale = 1,
			  shift = {0, 0},
			  stripes =
			  {
				{
				filename = "__EndgameCombat__/graphics/entity/tower/sprite.png",
				 width_in_frames = 1,
				 height_in_frames = 1
				},
			  },
			},
			{
			  priority = "low",
			  width = 850,
			  height = 170,
			  frame_count = 1,
			  draw_as_shadow = true,
			  direction_count = 1,
			  scale = 1,
			  shift = {0, 0},
			  stripes = 
			  {
			   {
				filename = "__EndgameCombat__/graphics/entity/tower/shadow.png",
				width_in_frames = 1,
				height_in_frames = 1
			   },
			  },
			}
		  }
		},
		turret_animation =
		{
		  layers =
		  {
			{
			  filename = "__core__/graphics/empty.png",
			  priority = "low",
			  width = 1,
			  height = 1,
			  frame_count = 1,
			  direction_count = 1,
			},
		  }
		},
		turret_rotation_speed = 10e-20,
		sound_no_fuel = nil,
		stop_trigger_speed = 10e-20,
		stop_trigger = nil,
		sound_minimum_speed = 10e-20;
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		working_sound = nil,
		open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
		close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
		rotation_speed = 0.015,
		weight = 10e10,
		guns = {},
		inventory_size = 10
	}
})