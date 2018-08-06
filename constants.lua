--[[
REPAIR_CHANCES = {1/2048, 1/512, 1/128, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2}
REPAIR_FACTORS = {0.03125, 0.0625, 0.125, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5}
REPAIR_LIMITS = {1, 2, 5, 10, 25}
--]]

REPAIR_CHANCES = {}
REPAIR_FACTORS = {}
REPAIR_LIMITS = {}

local function addRepairTier(chance, factor, limit)
	chance = chance/60 --seconds to ticks
	factor = factor/100 --% to raw
	REPAIR_CHANCES[#REPAIR_CHANCES+1] = chance
	REPAIR_FACTORS[#REPAIR_FACTORS+1] = factor
	REPAIR_LIMITS[#REPAIR_LIMITS+1] = limit
end

addRepairTier(1/64, 1, 1) --was 1/2048
addRepairTier(1/64, 2.5, 2) --was 1/512
addRepairTier(1/32, 5, 5) --was 1/128
addRepairTier(1/32, 10, 10) --was 1/64
addRepairTier(1/16, 25, 25) --was 1/32
addRepairTier(1/16, 25, 40) --was 1/16
addRepairTier(1/8, 25, 50) --was 1/8
addRepairTier(1/4, 40, 100) --was 1/6
addRepairTier(1/2, 40, 200) --was 1/4
addRepairTier(1, 50, 250) --was 1/2

NAPALM_RADIUS = 36
RADIATION_RADIUS = 80--60--45

SHOCKWAVE_TURRET_RADIUS = 10
SHOCKWAVE_TURRET_SCAN_RADIUS = 15
SHOCKWAVE_TURRET_DISCHARGE_ENERGY = 250000 --in J

CANNON_TURRET_RANGE = 35
CANNON_TURRET_INNER_RANGE = 12 --spitters have a 15 tile range, putting them *just* outside this radius

LIGHTNING_TURRET_RANGE = 8
LIGHTNING_TURRET_SCAN_RADIUS = 12
LIGHTNING_TURRET_DISCHARGE_ENERGY = 6000000 --in J
LIGHTNING_TURRET_DAMAGE = 12000
LIGHTNING_TURRET_HEALTH_THRESHOLD = 500
LIGHTNING_TURRET_RECHARGE_TIME = 60*10 --17.5 second recharge time (set by charge sound length), then a 10-second sound was used instead
LIGHTNING_TURRET_RECHARGE_TIME_REDUCTION_PER_TECH = 60*0.5 -- therefore down to 7.5s at level 5

SHIELD_REACTIVATE_FRACTION = 0.2
MAX_DOME_STRENGTH_TECH_LEVEL = 100
MAX_DOME_RECHARGE_TECH_LEVEL = 40

local f = 2 --not needed to be big anymore, since have techs
SHIELD_DOMES = { --energy per point in kJ, max recharge and idle drain in MW
	["small"]	=	{radius=16,	armor=1000,	strength=500*f,	energy_per_point=450/f,		max_recharge=5.0,	idle_drain=1.0,		color1 = {r = 0.1412, g = 0.851, b = 0},	color2 = {r = 0.7098, g = 1, b = 0}},	--recharges 11.111 pt/sec = 45 sec for full recharge, 9s to reactivate
	["medium"]	=	{radius=24,	armor=2500,	strength=2000*f,energy_per_point=2250/f,	max_recharge=15.0,	idle_drain=4.0,		color1 = {r = 1, g = 0.6863, b = 0},		color2 = {r = 1, g = 1, b = 0}},		--recharges 6.667 pt/sec = 300 sec (5 min) for full recharge, 60s to reactivate
	["big"]		=	{radius=36,	armor=5000,	strength=5000*f,energy_per_point=9000/f,	max_recharge=50.0,	idle_drain=10.0,	color1 = {r = 0, g = 0.784, b = 1},			color2 = {r = 0.5, g = 1, b = 1}},		--recharges 5.555 pt/sec = 900 sec (15 min) for full recharge, 180s to reactivate
}

HEAVY_TRAIN_FACTOR = 25

TURRET_RANGE_BOOSTS = {1, 1, 1, 1, 2, 2, 2, 2, 3, 5} --totals 1, 2, 3, 4, 6, 8, 10, 12, 15, 20
TURRET_RANGE_BOOST_SUMS = {}

local sum = 0
for i = 1,#TURRET_RANGE_BOOSTS do
	sum = sum+TURRET_RANGE_BOOSTS[i]
	TURRET_RANGE_BOOST_SUMS[#TURRET_RANGE_BOOST_SUMS+1] = sum
end

RADIATION_LIFE_VAR_MIN = -30
RADIATION_LIFE_VAR_MAX = 60
RADIATION_LIFE_VAR_STEP = 5

RADIATION_LIFES = {}

for lifevar = RADIATION_LIFE_VAR_MIN,RADIATION_LIFE_VAR_MAX,RADIATION_LIFE_VAR_STEP do
	RADIATION_LIFES[#RADIATION_LIFES+1] = lifevar
end

AMMO_CRATE_CAPACITY = 100 --default is 10