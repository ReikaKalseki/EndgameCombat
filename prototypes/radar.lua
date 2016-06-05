data:extend(
{
  {
    type = "item",
    name = "big-radar",
    icon = "__EndgameCombat__/graphics/icons/radar.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "f[radar]-f[big-radar-1-2]",
    place_result = "big-radar",	
    stack_size = 50
  },
}
)

data:extend(
{
  {
    type = "radar",
    name = "big-radar",
    icon = "__EndgameCombat__/graphics/icons/radar.png",
    flags = {"placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "big-radar"},
    max_health = 400,
    corpse = "big-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_per_sector = "40MJ",
    max_distance_of_sector_revealed = 12,
    max_distance_of_nearby_sector_revealed = 12,
    energy_per_nearby_scan = "500kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "2400kW",
    pictures =
    {
      filename = "__EndgameCombat__/graphics/entity/radar/radar.png",
      priority = "low",
      width = 153,
      height = 131,
      apply_projection = false,
      direction_count = 64,
      line_length = 8,
      shift = {0.875, -0.34375}
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/radar.ogg"
        }
      },
      apparent_volume = 2,
    }
  },
}
)