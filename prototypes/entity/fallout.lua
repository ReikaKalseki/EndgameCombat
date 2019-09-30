local alpha = 0.33--1

local function createCloudVariant(name, size, duration, damage, speed)
	local ret = {
    type = "smoke-with-trigger",
    name = "fallout-" .. name,
    flags = {"placeable-off-grid", "not-on-map"},
    show_when_smoke_off = true,
    animation =
    {
		layers = 
		{
			{
			  filename = "__EndgameCombat__/graphics/entity/radiation/radiation_final_tinted.png",
			  line_length = 16,
			  width = 256,
			  height = 181,
			  frame_count = 128,
			  axially_symmetrical = false,
			  direction_count = 1,
			  blend_mode = "additive",
			  animation_speed = 0.5*speed,
			  scale = size/5
			  --shift = { -0.0390625, -0.90625 }
			},
		}
    },
    slow_down_factor = 0,
	movement_slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = math.ceil(60 * duration),
	fade_in_duration = 60,
    fade_away_duration = math.ceil((duration/3) * 60),
    color = { r = alpha, g = alpha, b = alpha },
	light = {intensity = 0.3, size = 20, color={r=0, g=1, b=0}},
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
            radius = size*0.7,
            --entity_flags = {"placeable-player", "player-creation", "player", },
            action_delivery =
            {
              type = "instant",
              target_effects =
			  {
				  {
					type = "damage",
					damage = { amount = damage, type = "radiation"}
				  }
			  }
            }
          }
        }
      }
    },
    action_cooldown = 5
  }
  return ret
end

local function createCloud(name, size, duration, damage)
	local num = 6
	for i = 0,num do
		local f = 1+((-num/2)+i)/num
		--log(i .. " > " .. f)
		local dur = duration*math.sqrt(f)
		local s = size*(1+i*0.08)
		local sp = 1+i*0.04--1--(1+(1-(f-1)))^4
		data:extend({
			createCloudVariant(name .. "-" .. i, s, dur, damage, sp)
		})
	end
end


createCloud("small", 5, 60, 3) --1m
createCloud("medium", 8, 180, 5) --2.5m
createCloud("big", 12, 900, 8) --15 min
createCloud("huge", 18, 7200, 15) --2h