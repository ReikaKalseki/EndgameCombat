-- New category for turret cannon shells
data:extend(
{
  {
    type = "ammo-category",
    name = "cannon-shell-magazine"
  },
})

-- New cannon turret shell magazine ammo items
-- same as shells but with magazin_size and the new cannon-shell-magazine ammo type exclusive to turrets.
data:extend(
{
  {
    type = "ammo",
    name = "cannon-shell-magazine",
    description = "cannon-shell-magazine",
    icon = "__EndgameCombat__/graphics/icons/cannon-shell-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell-magazine",
      target_type = "entity",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "cannon-magazine-projectile",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 60,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "d[cannon-shell-magazine]-a[basic]",
    stack_size = 200
  },
  {
    type = "ammo",
    name = "explosive-cannon-shell-magazine",
    description = "explosive-cannon-shell-magazine",
    icon = "__EndgameCombat__/graphics/icons/explosive-cannon-shell-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell-magazine",
      target_type = "position",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "explosive-cannon-magazine-projectile",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 60,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "d[cannon-shell-magazine]-c[explosive]",
    stack_size = 200
  },
  {
    type = "ammo",
    name = "uranium-cannon-shell-magazine",
    description = "uranium-cannon-shell-magazine",
    icon = "__EndgameCombat__/graphics/icons/uranium-cannon-shell-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell-magazine",
      target_type = "entity",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "uranium-cannon-magazine-projectile",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 60,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "d[cannon-shell-magazine]-e[uranium]",
    stack_size = 200
  },
  {
    type = "ammo",
    name = "explosive-uranium-cannon-shell-magazine",
    description = "explosive-uranium-cannon-shell-magazine",
    icon = "__EndgameCombat__/graphics/icons/explosive-uranium-cannon-shell-magazine.png",
	icon_size = 32,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell-magazine",
      target_type = "position",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "explosive-uranium-cannon-magazine-projectile",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 60,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    magazine_size = 10,
    subgroup = "ammo",
    order = "d[explosive-cannon-shell-magazine]-e[uranium]",
    stack_size = 200
  },
})

-- Blueprints for new turrent cannon ammo shell magazine

-- All cannon turret ammo shell magazine share the same receipe appart from the base shell ingredient
-- inputs = array(name, ingredient)
function build_ammo_recipe(inputs)
return
{
  type = "recipe",
  name = inputs.name,
  enabled = false,
  energy_required = 2,
  ingredients = 
  {
    {"iron-plate", 2},
    {"plastic-bar", 1},
    {inputs.ingredient, 10},
  },
  result = inputs.name,
  result_count = 1,
  requester_paste_multiplier = 10,
}
end

data:extend(
{
  build_ammo_recipe{name = "cannon-shell-magazine", ingredient = "cannon-shell"},
  build_ammo_recipe{name = "explosive-cannon-shell-magazine", ingredient = "explosive-cannon-shell"},
  build_ammo_recipe{name = "uranium-cannon-shell-magazine", ingredient = "uranium-cannon-shell"},
  build_ammo_recipe{name = "explosive-uranium-cannon-shell-magazine", ingredient = "explosive-uranium-cannon-shell"},
})

-- New projectiles behavior for cannon turret shell magazine, same as shells but no collision box
data:extend(
{
  {
    type = "projectile",
    name = "cannon-magazine-projectile",
    flags = {"not-on-map"},
    -- collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    -- direction_only = true,
    piercing_damage = 300,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 200 , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 100 , type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
    {
    type = "projectile",
    name = "explosive-cannon-magazine-projectile",
    flags = {"not-on-map"},
    --collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    --direction_only = true,
    piercing_damage = 100,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 180, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {

          {
            type = "create-entity",
            entity_name = "big-explosion"
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 4,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 300, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
  {
    type = "projectile",
    name = "uranium-cannon-magazine-projectile",
    flags = {"not-on-map"},
    --collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    --direction_only = true,
    piercing_damage = 600,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 400 , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 200 , type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "uranium-cannon-explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
  {
    type = "projectile",
    name = "explosive-uranium-cannon-magazine-projectile",
    flags = {"not-on-map"},
    --collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    --direction_only = true,
    piercing_damage = 150,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 350 , type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "uranium-cannon-explosion"
          },
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "uranium-cannon-shell-explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 4.25,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 315, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "uranium-cannon-explosion"
                  }
                }
              }
            }
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    },
  },
})