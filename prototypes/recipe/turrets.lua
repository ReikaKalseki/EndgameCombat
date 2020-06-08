 data:extend(
{
 {
    type = "recipe",
    name = "concussion-turret",
    enabled = "false",
    ingredients =
    {
      {"gun-turret", 1},
      {"iron-gear-wheel", 20},
      {"electronic-circuit", 25},
    },
	energy_required = 20,
    result = "concussion-turret"
  },
   {
    type = "recipe",
    name = "plasma-turret",
    enabled = "false",
    ingredients =
    {
      {"laser-turret", 1},
      {"iron-gear-wheel", 10},
      {"processing-unit", 5},
    },
	energy_required = 30,
    result = "plasma-turret"
  },
 {
    type = "recipe",
    name = "cannon-turret",
    enabled = "false",
    ingredients =
    {
      {"gun-turret", 1},
      {"iron-gear-wheel", 40},
      {"advanced-circuit", 5},
      {"electronic-circuit", 20},
      {"stone", 10},
    },
    result = "cannon-turret"
  },
 {
    type = "recipe",
    name = "shockwave-turret",
    enabled = "false",
    ingredients =
    {
      {"iron-stick", 20},
      {"copper-cable", 80},
    },
    result = "shockwave-turret"
  },
 {
    type = "recipe",
    name = "last-stand-turret",
    enabled = "false",
    ingredients =
    {
      {type = "item", name = "storage-tank", amount=1},
      {type = "item", name = "land-mine", amount=4},
      {type = "item", name = "explosives", amount=100},
      {type = "item", name = "flamethrower-ammo", amount=10},
      {type = "item", name = "advanced-circuit", amount=2},
      {type = "fluid", name = "sulfuric-acid", amount=1000},
    },
	category = "crafting-with-fluid",
    result = "last-stand-turret"
  },
  {
    type = "recipe",
    name = "acid-turret",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"iron-gear-wheel", 25},
      {"pipe", 20},
      {"engine-unit", 5}
    },
    result = "acid-turret"
  },
  {
    type = "recipe",
    name = "sticky-turret",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {"iron-gear-wheel", 10},
      {"pipe", 12},
      --{"engine-unit", 2},
      {"stone-brick", 5}
    },
    result = "sticky-turret"
  },
 {
    type = "recipe",
    name = "lightning-turret",
    enabled = "false",
    ingredients =
    {
      {"copper-cable", 200},
      {"processing-unit", 18},
    },
    result = "lightning-turret"
  },
}
)