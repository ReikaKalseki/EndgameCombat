require "__DragonIndustries__.strings"

function createPlasmaBeam()
	local ret = table.deepcopy(data.raw.beam["laser-beam"])
	ret.name = "plasma-beam"
	local color = {r = 0.8, g = 0.0, b = 1.0}
	ret.width = ret.width*3
	ret.damage_interval = 12
	ret.light = {intensity = 0.75, size = 10}
	ret.working_sound = {
		  {
			filename = "__EndgameCombat__/sounds/plasma/laser-beam-01.ogg",
			volume = 0.9
		  },
		  {
			filename = "__EndgameCombat__/sounds/plasma/laser-beam-02.ogg",
			volume = 0.9
		  },
		  {
			filename = "__EndgameCombat__/sounds/plasma/laser-beam-03.ogg",
			volume = 0.9
		  }
		  
		}
	--ret.action.action_delivery.target_effects[1].damage.amount = 7.5 --vanilla laser is 10
	
	ret.head.filename = literalReplace(ret.head.filename, "__base__", "__EndgameCombat__")
	ret.head.height = 36
	ret.body[1].filename = literalReplace(ret.body[1].filename, "__base__", "__EndgameCombat__")
	ret.tail.height = 186
	ret.tail.filename = literalReplace(ret.tail.filename, "__base__", "__EndgameCombat__")
	ret.body[1].height = 36
	--ret.head_light.filename = literalReplace(ret.head_light.filename, "__base__", "__EndgameCombat__")
	--ret.body_light[1].filename = literalReplace(ret.body_light[1].filename, "__base__", "__EndgameCombat__")
	--ret.tail_light.filename = literalReplace(ret.tail_light.filename, "__base__", "__EndgameCombat__")

--[[	
	ret.head.tint = color
	ret.start.tint = color
	ret.ending.tint = color
	ret.tail.tint = color
	ret.body[1].tint = color
	--]]

	return ret
end