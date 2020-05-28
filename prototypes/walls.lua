require "__DragonIndustries__.registration"
require "__DragonIndustries__.cloning"

require "functions"

registerObjectArray(createDerivedWall("spiked-wall", 500, {modifier = 0.25, amount = 5, type = "cutting"},
{
	{ type = "physical", decrease = 3, percent = 20 },
	{ type = "impact", decrease = 45, percent = 60 },
	{ type = "explosion", decrease = 10, percent = 30 },
	{ type = "fire", percent = 100 },
	{ type = "laser", percent = 70 }
},
nil))

registerObjectArray(createDerivedWall("tough-wall", 2000, nil,
{
	{ type = "physical", decrease = 3, percent = 40 },
	{ type = "impact", decrease = 50, percent = 75 },
	{ type = "explosion", decrease = 15, percent = 40 },
	{ type = "fire", percent = 100 },
	{ type = "laser", percent = 100 }
},
8))

registerObjectArray(createDerivedWall("tough-spiked-wall", 5000, {modifier = 0.4, amount = 8, type = "cutting"},
{
	{ type = "physical", decrease = 5, percent = 40 },
	{ type = "impact", decrease = 60, percent = 80 },
	{ type = "explosion", decrease = 15, percent = 50 },
	{ type = "fire", percent = 100 },
	{ type = "laser", percent = 100 }
},
12))

local gate = copyObject("gate", "gate", "tough-gate")
local gateitem = copyObject("item", "gate", "tough-gate")
gate.max_health = 2000
gate.timeout_to_close = 5
gate.opening_speed = 0.0666666
gate.activation_distance = 3
gate.resistances = {
	{ type = "physical", decrease = 3, percent = 40 },
	{ type = "impact", decrease = 45, percent = 80 },
	{ type = "explosion", decrease = 10, percent = 30 },
	{ type = "fire", percent = 100 },
	{ type = "laser", percent = 70 }
}
reparentSprites("base", "EndgameCombat", gate)
reparentSprites("base", "EndgameCombat", gateitem)
gateitem.icon_size = 32
gateitem.icon_mipmaps = 0
gate.icon_size = 32
gate.icon_mipmaps = 0

data:extend({
gate, gateitem
})