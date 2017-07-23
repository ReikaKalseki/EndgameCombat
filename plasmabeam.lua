function createPlasmaAttack()
	local ret = {
		type = "beam",
		ammo_category = "electric",
		cooldown = 12,
		damage_modifier = 5,
		--projectile_center = {0, -0.2},
		--projectile_creation_distance = 1.4,
		range = 30,
		sound = { filename = "__EndgameCombat__/sounds/plasmashot.ogg", volume = 0.75 },
		ammo_type =
		{
		  category = "plasma-turret",
		  energy_consumption = "600kJ",
		  action =
		  {
			type = "direct",
			action_delivery =
			{
			  type = "beam",
			  beam = "laser-beam-purple",
			  max_length = 30,
			  duration = 12,
			  source_offset = {0, -1.3},
			}
		  }
		}
	}
	return ret
end

function createPlasmaBeam()
	local ret = {
		type = "beam",
		name = "laser-beam-purple",
		flags = {"not-on-map"},
		width = 0.5,
		damage_interval = 12,
		light = {intensity = 0.75, size = 10},
		working_sound =
		{
		  {
			filename = "__EndgameCombat__/sounds/laserbeam/laser-beam-01.ogg",
			volume = 0.9
		  },
		  {
			filename = "__EndgameCombat__/sounds/laserbeam/laser-beam-02.ogg",
			volume = 0.9
		  },
		  {
			filename = "__EndgameCombat__/sounds/laserbeam/laser-beam-03.ogg",
			volume = 0.9
		  }
		  
		},
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
				damage = { amount = 7.5, type = "laser"}
			  }
			}
		  }
		},
		head =
		{
			  filename = "__Laser_Beam_Turrets__/laser-beam-head-2.png",
			  line_length = 16,
			  tint = {r=0.75, g=0.1, b=1.0},
		  frame_count = 12,
		  x = 45*4,
			  width = 45,
			  height = 1,
			  priority = "high",
			  animation_speed = 0.5,
			  blend_mode = "additive-soft"
			},
		tail =
		{
			  filename = "__Laser_Beam_Turrets__/laser-beam-tail-3.png",
			  line_length = 16,
			  tint = {r=0.75, g=0.1, b=1.0},
		  frame_count = 12,
		  x = 48*4,
			  width = 48,
			  height = 24,
			  priority = "high",
			  animation_speed = 0.5,
			  blend_mode = "additive-soft"
			},
		body =
		{
		  {
			  filename = "__Laser_Beam_Turrets__/laser-beam-body-2.png",
			  line_length = 16,
			  tint = {r=0.75, g=0.1, b=1.0},
			  frame_count = 12,
		  x = 48*4,
			  width = 48,
			  height = 24,
			  priority = "high",
			  animation_speed = 0.5,
			  blend_mode = "additive-soft"
			},
		  
		}
	}
	return ret
end