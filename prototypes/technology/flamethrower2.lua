data:extend(
{
  {
    type = "technology",
    name = "flame-thrower-2",
    icon = "__base__/graphics/technology/flame-thrower.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "flame-thrower-2"
      }
    },
    prerequisites = {"flame-thrower", "military-3"},
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
    order = "e-c-b"
  }
}
)