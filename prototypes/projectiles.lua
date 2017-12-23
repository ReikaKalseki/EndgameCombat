data:extend({
  --[[{
    type = "projectile",
    name = "nuke-projectile",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              perimeter = 50,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
				  {
                    type = "damage",
                    damage = {amount = 1000, type = "physical"}
                  },
				  {
                    type = "damage",
                    damage = {amount = 600, type = "fire"}
                  },
				  {
                    type = "damage",
                    damage = {amount = 300, type = "acid"}
                  },
				  {
                    type = "damage",
                    damage = {amount = 600, type = "impact"}
                  },
                  {
                    type = "damage",
                    damage = {amount = 2000, type = "explosion"}
                  },
				  {
                    type = "damage",
                    damage = {amount = 500, type = "radiation"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            },
          }
        }
      }
    },
    light = {intensity = 0.85, size = 6},
    animation =
    {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    shadow =
    {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    smoke =
    {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },--]]
    {
    type = "projectile",
    name = "neutron-projectile",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 75,
			 entity_flags = {"placeable-enemy"},
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
				  {
                    type = "damage",
                    damage = {amount = 5000, type = "radiation"}
                  },
                }
              }
            },
          },
			{
          type = "create-entity",
          entity_name = "radiation-area-spawner",
		  trigger_created_entity = "true",
           }
        }
      }
    },
    light = {intensity = 0.95, size = 8},
    animation =
    {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    shadow =
    {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    smoke =
    {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },
      {
    type = "projectile",
    name = "napalm-projectile",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0.005,
    action = {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
		  {
            type = "create-entity",
            entity_name = "explosion"
          },
            {
              type = "create-fire",
              entity_name = "big-fire-flame"
            },
            {
              type = "damage",
              damage = { amount = 2, type = "fire" }
            },
			{
          type = "create-entity",
          entity_name = "fire-area-spawner",
		  trigger_created_entity = "true",
           }
          }
        }
      },
      {
        type = "area",
        radius = 30,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "fire-sticker"
            }
          }
        }
      }
	  },
    light = {intensity = 0.95, size = 8},
    animation =
    {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    shadow =
    {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 10,
      height = 30,
      priority = "high"
    },
    smoke =
    {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },
  
  --[[
  {
    type = "explosion",
    name = "uranium-explosion",
	icon_size = 32,
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__UraniumPower__/graphics/entity/explosions/uranium-explosion-1.png",
        priority = "extra-high",
        width = 256,
        height = 256,
        frame_count = 64,
		line_length = 8,
		scale = 3,
        animation_speed = 0.5
      },
    },
    light = {intensity = 1, size = 40},
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1,
    sound =
    {
      {
        filename = "__base__/sound/fight/small-explosion-1.ogg",
        volume = 0.75
      },
      {
        filename = "__base__/sound/fight/small-explosion-2.ogg",
        volume = 0.75
      }
    }
  },]]
  {
    type = "projectile",
    name = "hiex-cannon-projectile-big",
	icon_size = 32,
    flags = {"not-on-map"},
    collision_box = {{-0.05, -1.1}, {0.05, 1.1}},
    acceleration = 0,
    direction_only = true,
    piercing_damage = 20,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "massive-explosion"
          },
          {
            type = "damage",
            damage = { amount = 200 , type = "physical"}
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 15, --was 15
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {
					amount = 600, type = "explosion", --was 400, then 600, this only
					amount = 300, type = "impact",
					amount = 200, type = "fire",
					amount = 100, type = "physical"
					}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
	    },
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
    name = "plasma-laser",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "laser-bubble"
          },
          {
            type = "damage",
            damage = { amount = 7.5, type = "laser"}
          }
        }
      }
    },
    light = {intensity = 0.75, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
      tint = {r=0.75, g=0.1, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    },
    speed = 0.1875
  },
  
    {
    type = "projectile",
    name = "radiation-capsule",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "create-entity",
          entity_name = "radiation-cloud"
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__EndgameCombat__/graphics/entity/radiation-capsule/radiation-capsule.png",
      frame_count = 1,
      width = 32,
      height = 32,
      priority = "high"
    },
    shadow =
    {
      filename = "__EndgameCombat__/graphics/entity/radiation-capsule/radiation-capsule-shadow.png",
      frame_count = 1,
      width = 32,
      height = 32,
      priority = "high"
    },
    smoke = capsule_smoke,
  },
  {
    type = "smoke-with-trigger",
    name = "radiation-cloud",
	icon_size = 32,
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 3,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = 60 * 7.5,
    fade_away_duration = 2 * 60,
    spread_duration = 10,
    color = { r = 0.8, g = 0.7, b = 0.1 },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 15,
            entity_flags = {"placeable-enemy"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 180, type = "radiation"} --was 10
              }
            }
          }
        }
      }
    },
    action_cooldown = 10 --was 10
  },
      {
    type = "projectile",
    name = "acid-capsule",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "create-entity",
          entity_name = "acid-cloud"
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__EndgameCombat__/graphics/entity/acid-capsule/acid-capsule.png",
      frame_count = 1,
      width = 32,
      height = 32,
      priority = "high"
    },
    shadow =
    {
      filename = "__EndgameCombat__/graphics/entity/acid-capsule/acid-capsule-shadow.png",
      frame_count = 1,
      width = 32,
      height = 32,
      priority = "high"
    },
    smoke = capsule_smoke,
  },
  {
    type = "smoke-with-trigger",
    name = "acid-cloud",
	icon_size = 32,
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      flags = { "compressed" },
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 3,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = 60 * 5,
    fade_away_duration = 2 * 60,
    spread_duration = 10,
    color = { r = 0.6, g = 0.0, b = 1.0 },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 12,
            entity_flags = {"placeable-enemy", "breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 60, type = "acid"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 20
  },
    {
    type = "smoke-with-trigger",
    name = "fire-area-spawner",
	icon_size = 32,
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 3,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = 1,
    fade_away_duration = 1,
    spread_duration = 10,
    color = { r = 1.0, g = 0.8, b = 0.2 },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 12,
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 0, type = "fire"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 20
  },
    {
    type = "smoke-with-trigger",
    name = "radiation-area-spawner",
	icon_size = 32,
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 3,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = 1,
    fade_away_duration = 1,
    spread_duration = 10,
    color = { r = 0.3, g = 1.0, b = 0.2 },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 12,
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 0, type = "radiation"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 20
  },
})