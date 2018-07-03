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
	local ret = table.deepcopy(data.raw.beam["laser-beam-red"])
	local color = {r = 0.8, g = 0.0, b = 1.0}
	ret.name = "laser-beam-purple"
	ret.damage_interval = 12
	ret.light = {intensity = 0.75, size = 10}
	ret.working_sound = {
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
		  
		}
	ret.action.action_delivery.target_effects[1].damage.amount = 7.5
	
	
	ret.head.tint = color
	ret.start.tint = color
	ret.ending.tint = color
	ret.tail.tint = color
	ret.body[1].tint = color

	return ret
end