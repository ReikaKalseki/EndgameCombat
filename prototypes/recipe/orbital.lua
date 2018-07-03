 data:extend(
{
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
    },
    result= "destroyer-satellite"
  },
  {
    type = "recipe",
    name = "orbital-destroyer",
    energy_required = 60,
    enabled = false,
    category = "advanced-crafting",
    ingredients =
    {
      {"big-radar", 1},
      {"beacon", 10},
      {"processing-unit", 50},
      {"big-electric-pole", 10},
      {"refined-concrete", 200},
    },
    result= "orbital-destroyer"
  },
  {
    type = "recipe",
    name = "orbital-manual-target",
    energy_required = 0.5,
    enabled = false,
    ingredients =
    {
		{"processing-unit", 25},
		{"beacon", 1},
		{"copper-cable", 200}
    },
    result= "orbital-manual-target"
  },
  {
    type = "recipe",
    name = "orbital-scanner",
    energy_required = 0.5,
    enabled = false,
    ingredients =
    {
		{"advanced-circuit", 20},
		{"beacon", 1},
		{"copper-cable", 100}
    },
    result= "orbital-scanner"
  },
}
)