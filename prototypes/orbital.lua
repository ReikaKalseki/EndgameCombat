data:extend(
{
  {
    type = "item",
    name = "orbital-destroyer",
    icon = "__EndgameCombat__/graphics/icons/radar.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[plasma-turret]-f[orbital-destroyer-1-2]",
    place_result = "orbital-destroyer",	
    stack_size = 10
  },
  {
    type = "item",
    name = "destroyer-satellite",
    icon = "__EndgameCombat__/graphics/icons/satellite.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "intermediate-product",
    order = "q[satellite]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "destroyer-satellite",
    energy_required = 60,
    enabled = false,
    category = "advanced-crafting",
    ingredients =
    {
      {"satellite", 1},
      {"solar-panel", 200},
      {"plasma-turret", 50},
      {"fusion-reactor-equipment", 1},
    },
    result= "destroyer-satellite"
  },
}
)

data:extend(
{
  {
    type = "radar",
    name = "orbital-destroyer",
    icon = "__EndgameCombat__/graphics/icons/orbital-destroyer.png",
    flags = {"placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "orbital-destroyer"},
    max_health = 5000,
    corpse = "big-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    energy_per_sector = "100MJ",
    max_distance_of_sector_revealed = 1,
    max_distance_of_nearby_sector_revealed = 0,
    energy_per_nearby_scan = "100MJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "30MW",
    pictures =
    {
      filename = "__EndgameCombat__/graphics/entity/orbital/destroyer.png",
      priority = "low",
      width = 126,
      height = 180,
      apply_projection = false,
      direction_count = 64,
      line_length = 8,
      shift = {0.75, -1.75},
	  scale = 5/3*0.925,
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__EndgameCombat__/sounds/orbital-destroyer.ogg"
        }
      },
      apparent_volume = 2,
    }
  },
}
)

data:extend(
{
  {
    type = "corpse",
    name = "orbital-bombardment-crater",
    icon = "__EndgameCombat__/graphics/icons/orbital-crater.png",
    flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
    collision_box = {{-7.5, -7.5}, {7.5, 7.5}},
    collision_mask = {"doodad-layer", "not-colliding-with-itself"},
    selection_box = {{-7.5, -7.5}, {7.5, 7.5}},
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 10 * 18, -- 180 minutes
    final_render_layer = "ground_patch_higher2",
    subgroup = "remnants",
    order="d[remnants]-b[scorchmark]",
    animation =
    {
      width = 440,
      height = 360,
      frame_count = 1,
      direction_count = 1,
      variation_count = 1,
      filename = "__EndgameCombat__/graphics/entity/orbital/crater.png",
    },
    ground_patch = nil,--[[
    {
      sheet =
      {
      width = 440,
      height = 360,
      frame_count = 1,
      direction_count = 1,
      variation_count = 1,
	  x = 0,
      filename = "__EndgameCombat__/graphics/entity/orbital/crater.png",
      }
    },
    ground_patch_higher =
    {
      sheet =
      {
      width = 440,
      height = 360,
      frame_count = 1,
      direction_count = 1,
      variation_count = 1,
	  x = 0,
      filename = "__EndgameCombat__/graphics/entity/orbital/crater.png",
      }
    }--]]
  },
	{
    type = "explosion",
    name = "orbital-bombardment-firing-sound",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__EndgameCombat__/graphics/entity/orbital/firing.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 39,
        height = 100,
        frame_count = 24,
        line_length = 24,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {0, -1.75},
		scale = 2.0,
        animation_speed = 2,--0.5,
		blend_mode = "additive",
      }
    },
    light = {intensity = 0.8, size = 30, color = {r=1.0, g=0.7, b=0.9}},
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
          filename = "__EndgameCombat__/sounds/orbital-firing.ogg",
          volume = 0.8
        },
      }
    },
    created_effect = nil,
  },
	{
    type = "explosion",
    name = "orbital-bombardment-explosion",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__EndgameCombat__/graphics/entity/orbital/explosion.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 197,
        height = 245,
        frame_count = 47,
        line_length = 6,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {0.1875, -0.75},
		scale = 8.0,--2.0,
        animation_speed = 0.25,
		--blend_mode = "additive",
      }
    },
    light = {intensity = 1.0, size = 10, color = {r=1.0, g=0.6, b=0.2}},
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
          filename = "__EndgameCombat__/sounds/orbital-explosion.ogg",
          volume = 2.0
        },
      }
    },
    created_effect =
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
    },
  },
}
)