data:extend(
{
  {
    type = "equipment-grid",
    name = "huge-equipment-grid",
    width = 16,
    height = 32,
    equipment_categories = {"armor"}
  }
}
)

data:extend(
{
  {
    type = "armor",
    name = "power-armor-3",
    icon = "__EndgameCombat__/graphics/icons/power-armor-3.png",
    flags = {"goes-to-main-inventory"},
    resistances =
    {
      {
        type = "physical",
        decrease = 10,
        percent = 60
      },
      {
        type = "acid",
        decrease = 10,
        percent = 60
      },
      {
        type = "explosion",
        decrease = 20,
        percent = 70
      },
      {
        type = "radiation",
        percent = 100
      },
      {
        type = "impact",
		decrease = 50,
        percent = 90
      }
    },
    durability = 40000,
    subgroup = "armor",
    order = "e[power-armor-3]",
    stack_size = 1,
    equipment_grid = "huge-equipment-grid",
    inventory_size_bonus = 40
  },
  
  {
    type = "item",
    name = "advanced-laser-defense-equipment",
    icon = "__EndgameCombat__/graphics/icons/advanced-laser-defense-equipment.png",
    placed_as_equipment_result = "advanced-laser-defense-equipment",
    flags = {"goes-to-main-inventory"},
    subgroup = "equipment",
    order = "d[active-defense]-a[advanced-laser-defense-equipment]",
    stack_size = 20
  },
  {
    type = "item",
    name = "tintless-night-vision-equipment",
    icon = "__EndgameCombat__/graphics/icons/night-vision-equipment.png",
    placed_as_equipment_result = "tintless-night-vision-equipment",
    flags = {"goes-to-main-inventory"},
    subgroup = "equipment",
    order = "f[night-vision]-a[tintless-night-vision-equipment]",
    stack_size = 20
  },
  
    {
    type = "active-defense-equipment",
    name = "advanced-laser-defense-equipment",
    sprite =
    {
      filename = "__EndgameCombat__/graphics/equipment/advanced-laser-defense-equipment.png",
      width = 64,
      height = 96,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 3,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      buffer_capacity = "45kJ"
    },
    categories = {"armor"},
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 20,
      damage_modifier = 6,
      projectile_center = {0, 0},
      projectile_creation_distance = 0.6,
      range = 20,
      sound = make_laser_sounds(),
      ammo_type =
      {
        type = "projectile",
        category = "electric",
        energy_consumption = "20kJ",
        projectile = "laser",
        speed = 1,
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "laser",
                starting_speed = 0.28
              }
            }
          }
        }
      }
    },
    automatic = true
  },
    {
    type = "night-vision-equipment",
    name = "tintless-night-vision-equipment",
    sprite =
    {
      filename = "__EndgameCombat__/graphics/equipment/night-vision-equipment.png",
      width = 96,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 3,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "12kJ",
      input_flow_limit = "24kW",
      usage_priority = "primary-input"
    },
    energy_input = "1.5kW",
    tint = {r = 0.05, g = 0.1, b = 0.15, a = 0.01},
    categories = {"armor"}
  },
}
)