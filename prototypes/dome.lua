require "config"
require "constants"

--acts as a distractor of sorts, where biters will reach the "shield edge" (secretly entities) and attack those preferentially; if killed, they will move on to target the shield dome emitter itself(?); once down, they act as normal
--so: scan biters in radius, redirect aggro; watch entity-died for shield-edge and use ref lookup for getting shield itself, decrement its shield energy by the health of that entity
--try E:D shield mechanics:
--if shield level reaches zero, shield deactivates (no effect, no visuals); stays offline until reaches some threshold (eg 25%); shield recharges slowly, consuming LOTS of power in the process

local function createCircuitSprite()
	local ret = {
        filename = "__EndgameCombat__/graphics/entity/dome/circuit.png",
        x = 0,
        y = 0,
        width = 61,
        height = 50,
        frame_count = 1,
        shift = {0.140625, 0.140625},
    }
	return ret
end

local function createCircuitActivitySprite()
	local ret = {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-south.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {-0.296875, -0.078125},
    }
	return ret
end

local function createCircuitConnections()
	local ret = {
        shadow = {
          red = {0.375, 0.5625},
          green = {-0.125, 0.5625}
        },
        wire = {
          red = {0.375, 0.15625},
          green = {-0.125, 0.15625}
        }
    }
	return ret
end

data:extend({
  {
    type = "virtual-signal",
    name = "shield-level",
    icon = "__EndgameCombat__/graphics/icons/shield-dome-level.png",
    subgroup = "virtual-signal-special",
    order = "shield",
  },
  {
    type = "constant-combinator",
    name = "dome-circuit-connection",
    icon = "__base__/graphics/icons/constant-combinator.png",
    flags = {"placeable-neutral", "player-creation", "not-on-map", "placeable-off-grid"},
	order = "z",
	max_health = 1000000000,
	destructible = false,
	--collision_mask = {},

    --collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 1,

    sprites =
    {
      north = createCircuitSprite(),
      west = createCircuitSprite(),
      east = createCircuitSprite(),
      south = createCircuitSprite(),
    },

    activity_led_sprites = {
	  north = createCircuitActivitySprite(),
      west = createCircuitActivitySprite(),
      east = createCircuitActivitySprite(),
      south = createCircuitActivitySprite(),
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {-0.296875, -0.078125},
      {-0.296875, -0.078125},
      {-0.296875, -0.078125},
      {-0.296875, -0.078125},
    },

    circuit_wire_connection_points = {
      createCircuitConnections(),
      createCircuitConnections(),
      createCircuitConnections(),
      createCircuitConnections(),
    },

    circuit_wire_max_distance = 7.5
  }
})

local function createEmptyAnimation()
	local ret = {
		filename = "__EndgameCombat__/graphics/entity/dome/trans.png",
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

local function createEdgeSprite(name, params)
return
  {
    filename = "__EndgameCombat__/graphics/entity/dome/edge-" .. name .. ".png",
    priority = "extra-high",
    width = 80,
    height = 80,
	scale = 0.5,
    frame_count = 16,
	direction_count = 12,
  }
end

local ending_patch_prototype =
  {
    sheet =
    {
        filename = "__base__/graphics/entity/transport-belt/hr-start-end-integration-patches.png",
        width = 80,
        height = 80,
        priority = "extra-high",
        scale = 0.5
    }
  }

local function createShieldDome(name, params)
	data:extend({
		{
			type = "item",
			name = name .. "-shield-dome",
			icon = "__EndgameCombat__/graphics/icons/" .. name .. "-shield-dome.png",
			flags = {"goes-to-quickbar"},
			subgroup = "defensive-structure",
			order = "f[plasma-turret]-f[" .. name .. "-shield-dome-1-2]",
			place_result = name .. "-shield-dome",	
			localised_description = {"item-description.shield-dome", params.radius, params.strength, math.floor(params.max_recharge*1000/params.energy_per_point * 1000 + 0.5) / 1000, params.idle_drain, params.max_recharge},
			stack_size = 2
		},
		{
			type = "electric-turret",
			name = name .. "-shield-dome",
			render_layer = "object",
			icon = "__EndgameCombat__/graphics/icons/" .. name .. "-shield-dome.png",
			flags = {"placeable-player", "placeable-neutral", "player-creation"},
			order = "s-e-w-f",
			minable = {mining_time = 2.5, result = name .. "-shield-dome"},
			max_health = 400+params.strength/5,
			corpse = "big-remnants",
			dying_explosion = "massive-explosion",
			collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
			selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
			folding_animation = createEmptyAnimation(),
			folded_animation = createEmptyAnimation(),
			prepared_animation = createEmptyAnimation(),
			preparing_animation = createEmptyAnimation(),
			base_picture =
			{
			  filename = "__EndgameCombat__/graphics/entity/dome/emitter-" .. name .. ".png",
			  priority = "extra-high",
			  width = 258,
			  height = 186,
			  scale = 1.5,
			  shift = {4.25, -1.25},
			  frame_count = 1,
			},
			call_for_help_radius = 5,
			energy_source =
			{
			  type = "electric",
			  buffer_capacity = params.energy_per_point*20 .. "kJ", --20 ticks worth of recharge
			  input_flow_limit = params.max_recharge .. "MW",
			  drain = params.idle_drain .. "MW",
			  usage_priority = "primary-input"
			},
			attack_parameters =
			{
			  type = "projectile",
			  ammo_category = "electric",
			  cooldown = 20,
			  projectile_center = {-0.09375, -0.2},
			  projectile_creation_distance = 1.4,
			  range = params.radius,
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
		{
			type = "simple-entity-with-force",
			name = "shield-dome-edge-" .. name,
			flags = {"not-on-map", "placeable-off-grid"},
			render_layer = "lower-object",
			--icon = "__base__/graphics/icons/steel-chest.png",
			order = "s-e-w-f",
			max_health = 50,
			corpse = nil,
			collision_mask = {},
			--collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
			selectable_in_game = false,
			--selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			picture =
			{
			  filename = "__EndgameCombat__/graphics/entity/dome/trans.png",
			  priority = "high",
			  width = 5,
			  height = 5,
			  apply_projection = false,
			  frame_count = 1,
			  line_length = 1,
			  shift = {0, 0},
			  scale = 1,
			  animation_speed = 1,
			  blend_mode = "additive"
			},
		},
		{
			type = "smoke",
			name = "shield-dome-edge-effect-" .. name,
			flags = {"not-on-map", "placeable-off-grid"},
			--collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			--selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

			duration = 180,
			fade_in_duration = 30,
			fade_away_duration = 30,
			spread_duration = 10,
			start_scale = 1,
			end_scale = 1,
			cyclic = true,
			affected_by_wind = false,
			movement_slow_down_factor = 1,
			color = {r=1,g=1,b=1},--params.color2,
			render_layer = "lower-object",
			animation =
			{
			  filename = "__EndgameCombat__/graphics/entity/dome/edge-" .. name .. ".png",
			  priority = "extra-high",
			  width = 64,
			  height = 50,
			  apply_projection = false,
			  frame_count = 19,
			  line_length = 19,
			  shift = {0, 0},
			  scale = 2,
			  animation_speed = 0.5,
			  blend_mode = "additive"
			},
		},
		{
			type = "explosion",
			name = "shield-dome-effect-light-" .. name,
			flags = {"not-on-map", "placeable-off-grid"},
			--collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			--selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			light = {intensity = 0.75, size = 3*params.radius, color = {r=math.min(1, 0.4+params.color1.r*1.5), g=math.min(1, 0.4+params.color1.g*1.5), b=math.min(1, 0.4+params.color1.b*1.5)}},
			animations =
			{
				{
					filename = "__core__/graphics/empty.png",
					priority = "extra-high",
					width = 1,
					height = 1,
					frame_count = 1,
					animation_speed = 1/60,
				}
			},
		},
		{
			type = "explosion",
			name = "shield-dome-edge-effect-light-" .. name,
			flags = {"not-on-map", "placeable-off-grid"},
			--collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			--selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			light = {intensity = 0.375, size = 10, color = {r=math.min(1, 0.25+params.color2.r*1.5), g=math.min(1, 0.25+params.color2.g*1.5), b=math.min(1, 0.25+params.color2.b*1.5)}},
			animations =
			{
				{
					filename = "__core__/graphics/empty.png",
					priority = "extra-high",
					width = 1,
					height = 1,
					frame_count = 1,
					animation_speed = 0.005,
				}
			},
		},
		{
			type = "explosion",
			name = "shield-dome-fail-effect-light-" .. name,
			flags = {"not-on-map", "placeable-off-grid"},
			--collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			--selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			light = {intensity = 1, size = 50, color = {r=math.min(1, 0.4+params.color1.r*1.5), g=math.min(1, 0.4+params.color1.g*1.5), b=math.min(1, 0.4+params.color1.b*1.5)}},
			animations =
			{
				{
					filename = "__core__/graphics/empty.png",
					priority = "extra-high",
					width = 1,
					height = 1,
					frame_count = 1,
					animation_speed = 1/40,
				}
			},
		},
		{
			type = "smoke",
			name = "shield-dome-effect-" .. name,
			selectable_in_game = false,
			--icon = "__EndgameCombat__/graphics/icons/.png",
			flags = {"not-on-map", "placeable-off-grid"},
			duration = 300,
			fade_in_duration = 60,
			fade_away_duration = 60,
			spread_duration = 10,
			start_scale = 1,
			end_scale = 2,
			cyclic = false,
			affected_by_wind = false,
			movement_slow_down_factor = 1,
			color = {r=1,g=1,b=1},--params.color1,
			render_layer = "light-effect",
			animation =
			{
			  filename = "__EndgameCombat__/graphics/entity/dome/bubble-" .. name .. ".png",
			  priority = "high",
			  width = 170,
			  height = 140,
			  apply_projection = false,
			  frame_count = 36,
			  line_length = 9,
			  shift = {0, -1},
			  scale = 3.875*params.radius/SHIELD_DOMES["small"].radius,
			  animation_speed = 0.25,
			  blend_mode = "additive"
			},
		},
		{
			type = "smoke",
			name = "shield-dome-charging-effect-" .. name,
			selectable_in_game = false,
			--icon = "__EndgameCombat__/graphics/icons/.png",
			flags = {"not-on-map", "placeable-off-grid"},
			duration = 300,
			fade_in_duration = 60,
			fade_away_duration = 60,
			spread_duration = 10,
			start_scale = 1,
			end_scale = 2,
			cyclic = false,
			affected_by_wind = false,
			movement_slow_down_factor = 1,
			color = {r=1,g=1,b=1},--params.color1,
			render_layer = "light-effect",
			animation =
			{
			  filename = "__EndgameCombat__/graphics/entity/dome/pulse-" .. name .. ".png",
			  priority = "high",
			  width = 192,
			  height = 192,
			  apply_projection = false,
			  frame_count = 14,
			  line_length = 7,
			  shift = {0, -1},
			  scale = 4*params.radius/SHIELD_DOMES["small"].radius,
			  animation_speed = 0.25,
			  blend_mode = "additive"
			},
		},
		{
			type = "explosion",
			name = "shield-dome-fail-effect-" .. name,
			flags = {"not-on-map"},
			animations =
			{
			  {
				filename = "__EndgameCombat__/graphics/entity/dome/effect-" .. name .. ".png",
				priority = "extra-high",
				flags = { "compressed" },
				width = 197,
				height = 245,
				frame_count = 12,
				line_length = 6,
				axially_symmetrical = false,
				direction_count = 1,
				shift = {0, -1},
				scale = 4.0*params.radius/SHIELD_DOMES["small"].radius,--2.0,
				animation_speed = 0.5,
				blend_mode = "additive",
			  }
			},
			--light = {intensity = 1.0, size = 10, color = {r=1.0, g=0.6, b=0.2}},
			sound =
			{
			  aggregation =
			  {
				max_count = 10,
				remove = true
			  },
			  variations =
			  {
				{
				  filename = "__EndgameCombat__/sounds/shield-dome-fail.ogg",
				  volume = 2.0
				},
			  }
			},
		},
	})
end

for name,params in pairs(SHIELD_DOMES) do
	createShieldDome(name, params)
end