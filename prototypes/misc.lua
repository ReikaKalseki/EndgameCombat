require "config"
require "functions"

data:extend({
	{
    type = "logistic-container",
    name = "turret-logistic-interface",
    icon = "__EndgameCombat__/graphics/icons/turret-logistic-chest.png",
    flags = {"placeable-player", "player-creation", "not-on-map", "placeable-off-grid"},
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
	num_logistic_slots = 1,
    logistic_mode = "requester",
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
    circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.734375, 0.453125},
        green = {0.609375, 0.515625},
      },
      wire =
      {
        red = {0.40625, 0.21875},
        green = {0.40625, 0.375},
      }
    },
    circuit_wire_max_distance = 12,
    circuit_connector_sprites = get_circuit_connector_sprites({0.1875, 0.15625}, nil, 18),
  },
})