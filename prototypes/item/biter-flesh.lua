require "config"

data:extend(
{
  {
    type = "tool",
    name = "biter-flesh",
    icon = "__EndgameCombat__/graphics/icons/biter-flesh.png",
	icon_size = 32,
    flags = {},
    subgroup = "intermediate-product",
    order = "b[biter-flesh]",
    stack_size = 250,
	durability = 1,
	localised_description = Config.rottingFlesh and {"item-description.biter-flesh-rotting"} or {"item-description.biter-flesh"},
    durability_description_key = "description.biter-flesh-freshness"
  },
  {
    type = "capsule",
    name = "cooked-biter",
    icon = "__EndgameCombat__/graphics/icons/cooked-biter.png",
	icon_size = 32,
    flags = {},
    subgroup = "raw-resource",
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 30,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {type = "physical", amount = -240}
              }
            }
          }
        }
      }
    },
    order = "h[cooked-biter]",
    stack_size = 250
  },
})
