require "config"
require "functions"

local alerts = {}
local alertsByCategory = {}

local function getSoundForPriority(priority)
	if priority == 0 then
		return "immediate"
	elseif priority == 1 then
		return "critical"
	elseif priority == 2 then
		return "low"
	elseif priority == 3 then
		return "medium"
	end
end

local function getKeywordForPriority(priority)
	if priority == 0 then
		return "empty"
	elseif priority == 1 then
		return "critical"
	elseif priority == 2 then
		return "low"
	elseif priority == 3 then
		return "medium"
	end
end

local function createAlertSignal(category, priority, check, sound)
	local key = getKeywordForPriority(priority)
	local name = "turret-" .. category .. "-" .. key
	log("Creating alert " .. name)
	if check then
		local sound = sound and sound or getSoundForPriority(priority) --not key, since sound may not match priority
		alerts[name] = {name=name, sound="alert-" .. sound, callback = check, category = category, priority = priority}
		if not alertsByCategory[category] then alertsByCategory[category] = {} end
		alertsByCategory[category][priority] = name
	end
	if data and data.raw and not game then
		data:extend({{
			type = "virtual-signal",
			name = name,
			icon = "__EndgameCombat__/graphics/icons/" .. name .. ".png",
			icon_size = 64,
			subgroup = "virtual-signal-special",
			order = name,
		}})
	end
end

if data and data.raw and not game then
	data:extend({
		{
			type = "sound",
			name = "alert-low",
			filename = "__EndgameCombat__/sounds/alert-low.ogg",
			volume = 1
		},
		{
			type = "sound",
			name = "alert-critical",
			filename = "__EndgameCombat__/sounds/alert-critical.ogg",
			volume = 1
		},
		{
			type = "sound",
			name = "alert-immediate",
			filename = "__EndgameCombat__/sounds/alert-immediate.ogg",
			volume = 1
		},
	})
end

local function isHealthCritical(turret)
	return turret.health < 0.33*turret.prototype.max_health
end

local function isHealthLow(turret)
	return turret.health < 0.67*turret.prototype.max_health
end

local function isAmmoEmpty(turret)
	local inv = turret.get_inventory(defines.inventory.turret_ammo) 
	return inv[1] == nil or (not inv[1].valid_for_read)
end

local function getNestedTableValue(root, keys)
	local val = root
	for _,key in pairs(keys) do
		val = val[key]
		if not val then return nil end
	end
	return val
end

local function getDamageDealtThroughEffects(effects)
	if not effects then return 0 end
	local type = "physical"
	local ret = 0
	for _,effect in pairs(effects) do
		if effect.damage then
			ret = ret+effect.damage.amount
			if effect.damage.type then
				type = effect.damage.type
			end
		end
	end
	return ret, type
end

local function getAmmoTypeDamage(ammo)
	--local ret = getNestedTableValue(ammo, {"action", 1, "action_delivery", 1, "target_effects", 2, "damage", "amount"})
	--return ret and ret or 0
	local root = getNestedTableValue(ammo, {"action", 1, "action_delivery", 1})
	if root.projectile then
		local effects = getNestedTableValue(game.entity_prototypes[root.projectile].attack_result, {1, "action_delivery", 1, "target_effects"})
		return getDamageDealtThroughEffects(effects)
	elseif root.beam then
		local effects = getNestedTableValue(game.entity_prototypes[root.beam].attack_result, {1, "action_delivery", 1, "target_effects"})
		return getDamageDealtThroughEffects(effects)
	else
		return getDamageDealtThroughEffects(root.target_effects)
	end
end

--roughly aligns to spawn curve: 0-0.3 = small only; 0.3-0.5 adds medium,0.5-0.9 adds big, 0.9+ = behemoth
local function getAverageEnemyHealth(damage) --move this to a proper linear interpolate in 0.17 when can have centralized reference - probably want to cache into an array (2.5% granularity) for performance
	local evo = game.forces.enemy.evolution_factor
	local unit = nil
	if evo < 0.3 then
		unit = "small-biter"
	elseif evo < 0.5 then
		unit = "medium-biter"
	elseif evo < 0.9 then
		unit = "big-biter"
	else
		unit = "behemoth-biter"
	end
	local health = game.entity_prototypes[unit].max_health
	local res = game.entity_prototypes[unit].resistances
	if res and res[damage] and res[damage].percent then --simplified
		health = health*(1+res[damage].percent*2)
	end
	return health
end	

local function getTurretDealableDamage(turret)
	if turret.type == "ammo-turret" then
		local inv = turret.get_inventory(defines.inventory.turret_ammo)
		if not (inv[1] and inv[1].valid_for_read) then return 0 end
		local shots = inv[1].count*inv[1].prototype.magazine_size
		local info = inv[1].prototype.get_ammo_type("turret")
		local per, type = getAmmoTypeDamage(info)
		per = per*turret.prototype.attack_parameters.damage_modifier
		local tech1 = 1+turret.force.get_ammo_damage_modifier(info.category)
		local tech2 = 1+turret.force.get_turret_attack_modifier(turret.name)
		--game.print("Modifier " .. tech1 .. " for " .. info.category .. " and " .. tech2 .. " for turret")
		local per2 = per*tech1*tech2
		--game.print("Shots: " .. shots .. " ; dmg per = " .. per .. "; net " .. per2)
		per2 = math.min(per2, getAverageEnemyHealth("physical")) --clip to max health per enemy, since having 1 shot of 1000 damage does not mean you can kill 50x 20-health biters
		return shots*per2
	elseif turret.type == "electric-turret" then
		local param = turret.prototype.attack_parameters
		local info = param.ammo_type
		local dmg, type = getAmmoTypeDamage(info)
		local per = param.damage_modifier*dmg
		local tech1 = 1+turret.force.get_ammo_damage_modifier(info.category)
		local tech2 = 1+turret.force.get_turret_attack_modifier(turret.name)
		local per2 = per*tech1*tech2
		local cost = math.max(1, info.energy_consumption)
		local shots = turret.energy/cost
		--game.print("Modifier " .. tech1 .. " for " .. info.category .. " and " .. tech2 .. " for turret")
		--game.print("Shots: " .. shots .. " ; dmg per = " .. per .. "; net " .. per2)
		per2 = math.min(per2, getAverageEnemyHealth(type)) --clip to max health per enemy, since having 1 shot of 1000 damage does not mean you can kill 50x 20-health biters
		return shots*per2
	end
end

local function getCriticalDamageThreshold(damage)
	return getAverageEnemyHealth(damage)*5
end

local function getLowDamageThreshold(damage)
	return getAverageEnemyHealth(damage)*25
end

local function isAmmoCritical(turret)
	local inv = turret.get_inventory(defines.inventory.turret_ammo)
	if not (inv[1] and inv[1].valid_for_read) then return false end
	--game.print("Turret " .. turret.name .. " can deal a total damage of " .. getTurretDealableDamage(turret) .. " with " .. inv[1].count .. " of " .. inv[1].name)
	if Config.dynamicAlarms then
		--game.print("Comparing " .. getTurretDealableDamage(turret) .. " and " .. getCriticalDamageThreshold("physical"))
		return getTurretDealableDamage(turret) <= getCriticalDamageThreshold("physical")
	else
		local ammo = inv[1].count*inv[1].prototype.magazine_size
		return ammo <= Config.lowAmmoThreshold/3 or inv[1].count <= 1
	end
end

local function isAmmoLow(turret)
	local inv = turret.get_inventory(defines.inventory.turret_ammo) 
	if not (inv[1] and inv[1].valid_for_read) then return false end
	if Config.dynamicAlarms then
		--game.print("Comparing " .. getTurretDealableDamage(turret) .. " and " .. getLowDamageThreshold("physical"))
		return getTurretDealableDamage(turret) <= getLowDamageThreshold("physical")
	else
		local ammo = inv[1].count*inv[1].prototype.magazine_size
		return ammo <= Config.lowAmmoThreshold or inv[1].count <= 3
	end
end

local function isFluidEmpty(turret)
	local inv = turret.fluidbox[1]
	return inv == nil or inv[1] == nil or (not inv[1].valid)
end

local function isFluidCritical(turret)
	if not (turret.fluidbox[1] and turret.fluidbox[1].valid) then return false end
	local inv = turret.fluidbox[1].amount
	local cap = turret.fluidbox.get_capacity(1)
	return inv <= cap/4
end

local function isFluidLow(turret)
	if not (turret.fluidbox[1] and turret.fluidbox[1].valid) then return false end
	local inv = turret.fluidbox[1].amount
	local cap = turret.fluidbox.get_capacity(1)
	return inv <= cap/2
end

local function isEnergyEmpty(turret)
	--game.print("Turret " .. turret.name .. " can deal a total damage of " .. getTurretDealableDamage(turret) .. " with " .. turret.energy)
	return turret.energy <= 0
end

local function isEnergyLow(turret)
	if Config.dynamicAlarms then
		--game.print("Comparing " .. getTurretDealableDamage(turret) .. " and " .. getCriticalDamageThreshold("laser"))
		return getTurretDealableDamage(turret) <= getLowDamageThreshold("laser")
	else
		return turret.prototype.electric_energy_source_prototype and turret.energy < turret.prototype.electric_energy_source_prototype.buffer_capacity*0.67
	end
end

local function isEnergyCritical(turret)
	if Config.dynamicAlarms then
		--game.print("Comparing " .. getTurretDealableDamage(turret) .. " and " .. getLowDamageThreshold("laser"))
		return getTurretDealableDamage(turret) <= getCriticalDamageThreshold("laser")
	else
		return turret.prototype.electric_energy_source_prototype and turret.energy < turret.prototype.electric_energy_source_prototype.buffer_capacity*0.33
	end
end

createAlertSignal("health", 1, isHealthCritical, "immediate")
createAlertSignal("health", 2, isHealthLow)
createAlertSignal("ammo", 0, isAmmoEmpty)
createAlertSignal("ammo", 1, isAmmoCritical)
createAlertSignal("ammo", 2, isAmmoLow)
createAlertSignal("fluid", 0, isFluidEmpty)
createAlertSignal("fluid", 1, isFluidCritical)
createAlertSignal("fluid", 2, isFluidLow)
createAlertSignal("energy", 0, isEnergyEmpty)
createAlertSignal("energy", 1, isEnergyCritical)
createAlertSignal("energy", 2, isEnergyLow)

local function isCategoryApplicable(category, turret)
	if category == "ammo" then
		return turret.type == "ammo-turret" and turret.get_inventory(defines.inventory.turret_ammo) and #turret.get_inventory(defines.inventory.turret_ammo) > 0
	elseif category == "fluid" then
		return turret.type == "fluid-turret" and turret.fluidbox and #turret.fluidbox > 0
	elseif category == "energy" then
		return turret.type == "electric-turret"
	end
	return true
end

local function checkAllAlerts(turret)
	local ret = {}
	for category,li in pairs(alertsByCategory) do
		if isCategoryApplicable(category, turret) then
			for i = 0,3 do
				local key = li[i]
				if key then
					local alert = alerts[key]
					if alert.callback(turret) then
						table.insert(ret, alert.name)
						break --if hit an alarm, do not check lower-priority alerts
					end
				end
			end
		end
	end
	return ret
end

local function isAlarmNoLongerApplicable(alarm)
	if not alarm.turret.valid then return true end
	local func = alerts[alarm.type].callback
	return not func(alarm.turret)
end

function tickTurretAlarms(egcombat, tick)
	for _,player in pairs (game.connected_players) do
		if not egcombat.turret_alarms[player.force.name] then
			egcombat.turret_alarms[player.force.name] = {}
		end
		for unit,li in pairs(egcombat.turret_alarms[player.force.name]) do
			for type,alarm in pairs(li) do
				if alarm.turret.valid then
					if tick-alarm.time > 300 then --only trigger once per 5s
						--game.print("Refiring " .. type)
						updateTurretMonitoring(egcombat, alarm.turret) --in case alarm status has changed
						if isAlarmNoLongerApplicable(alarm) then
							--table.remove(alarms, i)
							li[type] = nil
							--game.print("Removing " .. type .. " as it no longer applies")
						else
							player.add_custom_alert(alarm.turret, {type = "virtual", name = type}, {"virtual-signal-name." .. type}, true)
							player.play_sound{path=alerts[type].sound, position=player.position, volume_modifier=1}
							alarm.time = tick
						end
					end
				else
					egcombat.turret_alarms[player.force.name][unit] = nil
					break
				end
			end
		end
	end
end

local function isDuplicateOrLessImportantAlarm(egcombat, turret, alarm)
	if not egcombat.turret_alarms[turret.force.name] then return false end
	if not egcombat.turret_alarms[turret.force.name][turret.unit_number] then return false end
	if egcombat.turret_alarms[turret.force.name][turret.unit_number][alarm] then return true end
	return false
end

local function cancelLessImportantAlarms(li, alarm)
	local cat = alerts[alarm].category
	local checks = alertsByCategory[cat]
	for priority,type in pairs(checks) do
		if priority > alerts[alarm].priority then	
			--game.print("Canceling " .. type .. " since " .. alarm .. " supersedes it")
			li[type] = nil
		end
	end
end

local function raiseTurretAlarm(egcombat, turret, alarm)
	if isDuplicateOrLessImportantAlarm(egcombat, turret, alarm) then
		--game.print("Skipping " .. alarm .. " since it already exists or is superseded by an already-existing one")
		return
	end
	--alarm = "turret-" .. alarm
	--game.print("Raising alarm " .. alarm)
	if Config.continueAlarms then
		if not egcombat.turret_alarms[turret.force.name] then
			egcombat.turret_alarms[turret.force.name] = {}
		end
		if not egcombat.turret_alarms[turret.force.name][turret.unit_number] then
			egcombat.turret_alarms[turret.force.name][turret.unit_number] = {}
		end
		egcombat.turret_alarms[turret.force.name][turret.unit_number][alarm] = {turret = turret, type = alarm, time = game.tick}
		cancelLessImportantAlarms(egcombat.turret_alarms[turret.force.name][turret.unit_number], alarm)
	end
	
	--raise immediately no matter what
	for _,player in pairs(game.connected_players) do
		if player.force == turret.force then
			player.add_custom_alert(turret, {type = "virtual", name = alarm}, {"virtual-signal-name." .. alarm}, true)
			player.play_sound{path=alerts[alarm].sound}
		end
	end
end

function updateTurretMonitoring(egcombat, turret)
	local force = turret.force
	if not force.technologies["turret-monitoring"].researched then return end
	
	if egcombat.placed_turrets[force.name] == nil then
		egcombat.placed_turrets[force.name] = {}
	end
	local entry = egcombat.placed_turrets[force.name][turret.unit_number]
	
	for _,alarm in pairs(checkAllAlerts(turret)) do
		raiseTurretAlarm(egcombat, turret, alarm)
	end
	--[[
	if turret.health < 0.125*turret.prototype.max_health then
		raiseTurretAlarm(egcombat, turret, "health-critical")
	elseif turret.health < 0.5*turret.prototype.max_health then
		raiseTurretAlarm(egcombat, turret, "health-low")
	end
	
	if turret.type == "ammo-turret" then
		local inv = entry.turret.get_inventory(defines.inventory.turret_ammo) 
		if inv[1] == nil or (not inv[1].valid_for_read) then
			raiseTurretAlarm(egcombat, turret, "ammo-empty")
		else
			local ammo = inv[1].count*inv[1].prototype.magazine_size
			if ammo <= Config.lowAmmoThreshold/4 then
				raiseTurretAlarm(egcombat, turret, "ammo-critical")
			elseif ammo <= Config.lowAmmoThreshold then
				raiseTurretAlarm(egcombat, turret, "ammo-low")
			end
		end
	elseif turret.type == "electric-turret" then
		local e = turret.energy
		if e == 0 then
			raiseTurretAlarm(egcombat, turret, "energy-empty")
		else
			local cap = turret.prototype.electric_energy_source_prototype and turret.prototype.electric_energy_source_prototype.buffer_capacity or nil
			if cap then
				if e <= cap/3 then
					raiseTurretAlarm(egcombat, turret, "energy-critical")
				elseif e <= cap*0.75 then
					raiseTurretAlarm(egcombat, turret, "energy-low")
				end
			end
		end
	elseif turret.type == "fluid-turret" then
		local inv = turret.fluidbox[1]
		if inv[1] == nil or (not inv[1].valid) then
			raiseTurretAlarm(egcombat, turret, "fluid-empty")
		else
			local ammo = inv[1].amount
			local cap = turret.fluidbox.get_capacity(1)
			if ammo <= cap/4 then
				raiseTurretAlarm(egcombat, turret, "fluid-critical")
			elseif ammo <= cap/2 then
				raiseTurretAlarm(egcombat, turret, "fluid-low")
			end
		end
	end
	--]]
end