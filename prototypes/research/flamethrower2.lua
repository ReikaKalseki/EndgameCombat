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
    prerequisites = {"refined-flammables-3", "military-3", "advanced-electronics-2"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "e-c-b",
    icon_size = 128,
  }
}
)