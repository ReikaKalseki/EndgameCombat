require "config"

local function createSprite(file, scale, speed)
     return {
        filename = file,
        priority = "extra-high",
        flags = { "compressed" },
        width = 197,
        height = 245,
        frame_count = 47,
        line_length = 6,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {2, -10},
		scale = scale*Config.artilleryRange/15,
        animation_speed = speed,
		render_layer = "higher-object-above",
		--blend_mode = "additive",
      }
end

data:extend({
	{
    type = "explosion",
    name = "artillery-impact-explosion-aux",
	icon_size = 32,
    flags = {"not-on-map"},
    animations =
    {
		createSprite("__EndgameCombat__/graphics/entity/artillery-explosion.png", 4.0, 0.375),
		createSprite("__EndgameCombat__/graphics/entity/artillery-explosion.png", 3.2, 0.55),
		createSprite("__EndgameCombat__/graphics/entity/artillery-explosion.png", 4.75, 0.25),
		createSprite("__EndgameCombat__/graphics/entity/artillery-explosion.png", 3.8, 0.333),
    },
    light = {intensity = 1.0, size = 10, color = {r=1.0, g=0.6, b=0.2}},--[[
    sound =
    {
      aggregation =
      {
        max_count = 10,
        remove = true
      },
      variations =
      {
        {
          filename = "__EndgameCombat__/sounds/artillery-explosion.ogg",
          volume = 2.0
        },
      }
    },--]]
    created_effect =
	{
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 20,
            particle_name = "explosion-remnants-particle",
            initial_height = 0.5,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.15,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.15,
            offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
          }
        }
      }
    },
  }
})

data.raw.explosion["big-artillery-explosion"].sound = {aggregation = { max_count = 10, remove = true }, variations = {{ filename = "__EndgameCombat__/sounds/artillery-explosion.ogg", volume = 2.0 }}}
data.raw.explosion["big-artillery-explosion"].animations[1].scale = 3.0
data.raw.explosion["big-artillery-explosion"].animations[1].render_layer = "explosion"

data.raw["artillery-projectile"]["artillery-projectile"].action.action_delivery.target_effects[1] = 
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = Config.artilleryRange,
			 entity_flags = {"placeable-enemy"},
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 15000, type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = {amount = 15000, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "artillery-impact-explosion-aux"
                  }
                }
              }
            }
}