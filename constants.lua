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
SHOCKWAVE_TURRET_DISCHARGE_ENERGY = 250000 --in J

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