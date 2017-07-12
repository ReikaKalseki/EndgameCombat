data:extend(
{
  {
    type = "equipment-grid",
    name = "huge-equipment-grid",
    width = 16,
    height = 24,
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
   
}
)