data:extend(
{
  {
    type = "technology",
    name = "flamethrower-2",
    icon = "__base__/graphics/technology/flamethrower.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "flamethrower-2"
      }
    },
    prerequisites = {"flamethrower", "military-3"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 30
    },
    order = "e-c-b",
    icon_size = 128,
  }
}
)