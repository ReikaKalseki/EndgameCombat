--require "defines"
require "util"
require "functions"
require "config"
require "constants"

require "shield-domes"
require "orbital-strikes"
require "turret-alerts"

function initGlobal(markDirty)
	if not global.egcombat then
		global.egcombat = {}
	end
	if global.egcombat.placed_turrets == nil then
		global.egcombat.placed_turrets = {}
	end
	if global.egcombat.robot_defence == nil then
		global.egcombat.robot_defence = {}
	end
	if global.egcombat.chunk_cache == nil then
		global.egcombat.chunk_cache = {}
	end
	if global.egcombat.fleshToDeconstruct == nil then
		global.egcombat.fleshToDeconstruct = {}
	end
	if global.egcombat.cannon_turrets == nil then
		global.egcombat.cannon_turrets = {}
	end
	if global.egcombat.shockwave_turrets == nil then
		global.egcombat.shockwave_turrets = {}
	end
	if global.egcombat.lightning_turrets == nil then
		global.egcombat.lightning_turrets = {}
	end
	if global.egcombat.orbital_indices == nil then
		global.egcombat.orbital_indices = {}
	end
	if global.egcombat.scheduled_orbital == nil then
		global.egcombat.scheduled_orbital = {}
	end
	if global.egcombat.scheduled_orbital_kills == nil then
		global.egcombat.scheduled_orbital_kills = {}
	end
	if global.egcombat.active_orbital_radar == nil then
		global.egcombat.active_orbital_radar = {}
	end
	if global.egcombat.shield_domes == nil then
		global.egcombat.shield_domes = {}
	end
	if global.egcombat.shield_dome_edges == nil then
		global.egcombat.shield_dome_edges = {}
	end
	if global.egcombat.turret_alarms == nil then
		global.egcombat.turret_alarms = {}
	end
	if global.egcombat.orbital_targetable == nil then
		global.egcombat.orbital_targetable = createOrbitalTargetableList()
	end
	global.egcombat.dirty = markDirty
	
	if remote.interfaces["silo-script"] then
		remote.call("silo_script", "set_show_launched_without_satellite", false)
		remote.call("silo_script", "add_tracked_item", "destroyer-satellite")
	end
end

local function convertTurretCache(egcombat)
	for k,force in pairs(game.forces) do
		if egcombat.placed_turrets[force.name] == nil then
			egcombat.placed_turrets[force.name] = {}
			--game.print("Adding force " .. force.name .. " to turret table")
		end
		if #egcombat.placed_turrets[force.name] > 0 then
			if egcombat.placed_turrets[force.name][1].surface then --if is made of pure entities, not entries containing entities
				game.print("Converting turret cache to entries.")
				local repl = {}
				for _,turret in pairs(egcombat.placed_turrets[force.name]) do
					local entry = createTurretEntry(turret)
					if entry then
						table.insert(repl, entry)
					end
				end
				egcombat.placed_turrets[force.name] = repl
			elseif isTableAnArray(egcombat.placed_turrets[force.name]) then --using int keys, not unit_number
				game.print("Converting turret cache to unit-based indexing.")
				local entries = {}
				for _,entry in pairs(egcombat.placed_turrets[force.name]) do
					entries[entry.turret.unit_number] = entry
				end
				egcombat.placed_turrets[force.name] = entries
			else --just clean up
				for e,turret in pairs(egcombat.placed_turrets[force.name]) do
					if not turret.valid then egcombat.placed_turrets[force.name][e] = nil end
				end
			end
		end
	end
end

script.on_init(function()
	initGlobal(true)
end)

script.on_configuration_changed(function()
	initGlobal(true)
	
	convertTurretCache(global.egcombat)
end)

local function track_turret(entity_list, turret)
    entity_list[turret.unit_number] = createTurretEntry(turret)
end

local function removeTurretFromCache(egcombat, turret)
	local entity_list = egcombat.placed_turrets[turret.force.name]
	--game.print("Reading remove of " .. turret.name .. " ID " .. turret.unit_number .. " in force " .. turret.force.name .. ", cache is " .. (entity_list ~= nil and "non-null" or "nil"))
	if not entity_list then return end
	--game.print(#entity_list)
    local entry =  entity_list[turret.unit_number]
	if not entry then --[[game.print("Turret " .. turret.name .. " had no entry?!")--]] return end --this is normal when rangeboost is enabled
	entity_list[turret.unit_number] = nil
	if entry.logistic then
		local inv = entry.logistic.get_inventory(defines.inventory.chest)
		for name,count in pairs(inv.get_contents()) do
			entry.logistic.surface.spill_item_stack(entry.logistic.position, {name=name, count=count}, true)
		end
		inv.clear()
		entry.logistic.destroy()
	end
end

local function trackNewTurret(egcombat, turret)
	local force = turret.force
	if force ~= game.forces.enemy then
		if egcombat.placed_turrets[force.name] == nil then
			egcombat.placed_turrets[force.name] = {}
		end
		if turret.force.technologies["turret-range-1"].researched then
			turret = convertTurretForRange(egcombat, turret, getTurretRangeResearch(turret.force), true)
		end
		track_turret(egcombat.placed_turrets[force.name], turret)
	
		checkAndCacheTurret(egcombat, turret, force)
		--[[
		if string.find(turret.name, "shockwave-turret", 1, true) then
			if egcombat.shockwave_turrets[force.name] == nil then
				egcombat.shockwave_turrets[force.name] = {}
			end
			table.insert(egcombat.shockwave_turrets[force.name], {turret=turret, delay=60})
			--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
		end
		--]]

		--game.print("Adding " .. turret.name .. " ID " .. turret.unit_number .. " @ " .. turret.position.x .. ", " .. turret.position.y .. " for force " .. force.name .. " to turret table")
	end
	
	return turret
end

local function reloadRangeTech()
	local egcombat = global.egcombat
	if egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.placed_turrets[force.name] then
					local repl = {}
					for id,entry in pairs(egcombat.placed_turrets[force.name]) do
						if entry.turret.valid then
							--game.print("Converting turret @ " .. entry.turret.position.x .. ", " .. entry.turret.position.y)
							entry.turret = upgradeTurretForRange(egcombat, entry.turret, getTurretRangeResearch(force))
							--game.print("Recaching upgraded turret " .. entry.turret.name .. " @ " .. entry.turret.position.x .. ", " .. entry.turret.position.y .. " with new entry " .. (entry and "nonnull" or "nil"))
							--trackNewTurret(egcombat, entry.turret)
							--replaceTurretInCache(egcombat, force, entry.turret, id, entry)
							repl[entry.turret.unit_number] = entry
						else
							game.print("Skipping invalid turret during range tech reload " .. id)
						end
					end
					
					egcombat.placed_turrets[force.name] = {}
					for id,entry in pairs(repl) do
						egcombat.placed_turrets[force.name][id] = entry
					end
				end
			end
		end
	end
end

script.on_event(defines.events.on_sector_scanned, function(event)	
	local force = event.radar.force
	if event.radar.name == "orbital-destroyer" then
		local index = getOrCreateIndexForOrbital(event.radar)
		--game.print("Got index " .. index .. " for orbital # " .. event.radar.unit_number .. " @ " .. event.radar.position.x .. ", " .. event.radar.position.y .. "; is out of " .. force.get_item_launched("destroyer-satellite"))
		if force.get_item_launched("destroyer-satellite") > index then
			fireOrbitalWeapon(force, event.radar)
		end
	end
end)

script.on_event(defines.events.on_console_command, function(event)
	if event.command == "c" and string.find(event.parameters, "technologies[\"turret-range", 1, true) and string.find(event.parameters, "].researched", 1, true) then
		game.print("EndgameCombat: Reloading turret ranges.")
		reloadRangeTech()
	end
end)

script.on_event(defines.events.on_trigger_created_entity, function(event)
	if event.entity.name == "fire-area-spawner" then
		spawnFireArea(event.entity)
	end
	if event.entity.name == "fire-cloud" or event.entity.name == "fire-cloud-auto" then
		spawnCapsuleFireArea(event.entity)
	end
	if event.entity.name == "radiation-area-spawner" then
		spawnRadiationArea(event.entity)
	end
end)

script.on_event(defines.events.on_tick, function(event)
	local egcombat = global.egcombat
	
	if egcombat.dirty then		
		--[[
		for chunk in game.surfaces["nauvis"].get_chunks() do
			table.insert(egcombat.chunk_cache, chunk)
		end
		--]]
		
		for k,force in pairs(game.forces) do
			if egcombat.placed_turrets[force.name] == nil then
				egcombat.placed_turrets[force.name] = {}
				--game.print("Adding force " .. force.name .. " to turret table")
			end
		end
		
		egcombat.dirty = false
	end
	
	if egcombat.orbital_targetable == nil then
		egcombat.orbital_targetable = createOrbitalTargetableList()
	end
	
	if Config.continueAlarms and event.tick%60 == 0 then
		tickTurretAlarms(egcombat, event.tick)
	end
	
	if egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				--game.print("Force " .. force.name .. ": " .. #egcombat.placed_turrets[force.name] .. " turrets placed.")
				if egcombat.placed_turrets[force.name] then
					if force.technologies["healing-alloys-1"].researched then
						repairTurrets(egcombat, force)
					end
					if force.technologies["turret-logistics"].researched and event.tick%120 == 0 then
						handleTurretLogistics(egcombat, force)
					end
				end
			end
		end
	end
	
	if egcombat.shockwave_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.shockwave_turrets[force.name] then
					for i, entry in ipairs(egcombat.shockwave_turrets[force.name]) do
						if entry.turret.valid then
							tickShockwaveTurret(entry, event.tick)
						else
							table.remove(egcombat.shockwave_turrets[force.name], i)
						end
					end
				end
			end
		end
	end
	
	if egcombat.cannon_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.cannon_turrets[force.name] then
					for i, entry in ipairs(egcombat.cannon_turrets[force.name]) do
						if entry.turret.valid then
							tickCannonTurret(entry, event.tick)
						else
							table.remove(egcombat.cannon_turrets[force.name], i)
						end
					end
				end
			end
		end
	end
	
	if egcombat.lightning_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.lightning_turrets[force.name] then
					for unit, entry in pairs(egcombat.lightning_turrets[force.name]) do
						if entry.turret.valid then
							tickLightningTurret(entry, event.tick)
						else
							egcombat.lightning_turrets[force.name][unit] = nil
						end
					end
				end
			end
		end
	end
	
	if egcombat.shield_domes then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.shield_domes[force.name] then
					for unit, entry in pairs(egcombat.shield_domes[force.name]) do
						if entry.dome.valid then
							tickShieldDome(egcombat, entry, event.tick)
						else
							for biter,edge in pairs(entry.edges) do
								edge.entity.destroy()
								edge.effect.destroy()
								if edge.light and edge.light.valid then
									edge.light.destroy()
								end
							end
							if entry.circuit then
								entry.circuit.disconnect_neighbour(defines.wire_type.red)
								entry.circuit.disconnect_neighbour(defines.wire_type.green)
								entry.circuit.destroy()
							end
							egcombat.shield_domes[force.name][unit] = nil
						end
					end
				end
			end
		end
	end
	
	tickOrbitalStrikeSchedule(egcombat)
	tickOrbitalScans(egcombat)
	
	if #egcombat.fleshToDeconstruct > 0 then
		for i = #egcombat.fleshToDeconstruct,1,-1 do --iterate in reverse since removing entries
			local entry = egcombat.fleshToDeconstruct[i]
			local item = entry.entity ~= nil and entry.entity or entry[1]
			local tick = entry.time ~= nil and entry.time or entry[2]
			if event.tick >= tick or not item.valid then
				if item.valid then
					item.order_deconstruction(game.forces.player)
				end
				table.remove(egcombat.fleshToDeconstruct, i)
			end
		end
	end
	
	if Config.rottingFlesh and math.random() < 0.1 then
		for _,player in pairs(game.players) do
			if math.random() < 0.2 then
				local invs = {defines.inventory.player_main, defines.inventory.player_quickbar, defines.inventory.player_tools, defines.inventory.player_vehicle}
				--for _,inv in pairs(invs) do
				local inv = invs[math.random(1, #invs)]
					local iinv = player.get_inventory(inv)
					if iinv then
						local flesh = iinv.find_item_stack("biter-flesh")
						local d = 0.001*10 --to counteract the 0.1 above
						if flesh and flesh.valid_for_read then
							if flesh.durability-d > 0 then
								flesh.durability = math.max(0, flesh.durability-d)
							else
								flesh.count = flesh.count-1
							end
						end
					end
				--end
			end
		end
	end
	
	if #game.players > 0 and event.tick%60 == 0 then
		local player = game.players[math.random(1, #game.players)]
		cleanTissueNearPlayer(egcombat, player)
	end
end)

local function onFinishedResearch(event)
	local tech = event.research.name
	local force = event.research.force.name
	local egcombat = global.egcombat
	convertTurretCache(egcombat)
	if string.find(tech, "turret-range", 1, true) then
		local lvl = tonumber(string.match(tech, "%d+"))
		--game.print("Turret range " .. lvl)
		if egcombat.placed_turrets[force] == nil then
			egcombat.placed_turrets[force] = {}
		end
		local repl = {}
		for k,entry in pairs(egcombat.placed_turrets[force]) do
			--game.print("Attempting to convert ID " .. k .. " to " .. lvl .. ": " .. (entry.turret.valid and "valid" or "invalid"))
			if entry.turret.valid then
				--game.print("Converting " .. turret.name .. " @ "  .. turret.position.x .. ", " .. turret.position.y .. " to tier " .. lvl)
				local ret = convertTurretForRangeWhileKeepingSpecialCaches(egcombat, entry.turret, lvl, false)
				--repl[ret.unit_number] = entry
				entry.turret = ret
				table.insert(repl, {entry = entry, unit = ret.unit_number})
			else
				egcombat.placed_turrets[force][k] = nil
			end
		end
		--game.print("Attempting to recache " .. #repl .. " turrets")
		egcombat.placed_turrets[force] = {}
		for _,data in pairs(repl) do
			egcombat.placed_turrets[force][data.unit] = data.entry
			--game.print("Recached " .. data.entry.turret.name .. " ID " .. data.unit)
		end
	end
	if tech == "turret-logistics" then
		if egcombat.placed_turrets[force] == nil then
			egcombat.placed_turrets[force] = {}
		end
		for k,entry in pairs(egcombat.placed_turrets[force]) do
			if entry.turret.valid then
				--game.print("Creating logistic interface for " .. entry.turret.name .. " @ " .. entry.turret.position.x .. ", " .. entry.turret.position.y)
				--if entry.logistic then entry.logistic.destroy() end
				entry.logistic = createLogisticInterface(entry.turret)
			end
		end
	end
	if tech == "logistic-defence" then
		egcombat.robot_defence[force] = 0.8
	end
	if tech == "logistic-defence-2" then
		egcombat.robot_defence[force] = 1.5
	end
	if string.find(tech, "shield-dome-strength", 1, true) then
		local lvl = tonumber(string.match(tech, "%d+"))
		--game.print("Dome strength " .. lvl)
		if egcombat.shield_domes[force] == nil then
			egcombat.shield_domes[force] = {}
		end
		for _,entry in pairs(egcombat.shield_domes[force]) do
			entry.strength_factor = getCurrentDomeStrengthFactorByLevel(lvl)
		end
	end
	if string.find(tech, "shield-dome-recharge", 1, true) then
		local lvl = tonumber(string.match(tech, "%d+"))
		--game.print("Dome recharge " .. lvl)
		if egcombat.shield_domes[force] == nil then
			egcombat.shield_domes[force] = {}
		end
		for _,entry in pairs(egcombat.shield_domes[force]) do
			entry.cost_factor = getCurrentDomeCostFactorByLevel(lvl)
		end
	end
end

script.on_event(defines.events.on_put_item, function(event)	
	local player = game.players[event.player_index]
	local stack = player.cursor_stack
	
	if not (stack.valid_for_read) then
		return
	end
	
	if stack.name == "orbital-manual-target" then
		scheduleOrbitalStrike(player, player.get_inventory(defines.inventory_player_main), event.position)
		return
	end
	
	if stack.name == "orbital-scanner" then
		scanAreaForStrike(global.egcombat, player.surface, event.position, player.force)
		return
	end
end)

local function onEntityAdded(event)	
	local entity = event.created_entity
	local placer = event.player_index and game.players[event.player_index] or event.robot
	local egcombat = global.egcombat
	
	if entity.name == "orbital-manual-target" or entity.name == "orbital-scanner" then
		game.players[event.player_index].insert{name = entity.name} --not placeable by robot, so can assume player
		entity.destroy()
		return
	end
	
	if entity.type == "entity-ghost" then
        if string.find(entity.ghost_name, "rangeboost") then
			--game.print("Converting ghost")
			local time = entity.time_to_live
            local new = entity.surface.create_entity({name = entity.name, position = entity.position, force = entity.force, direction = entity.direction, inner_name = getTurretBaseNameByName(entity.ghost_name)})
            entity.destroy()
			new.time_to_live = time
			return
        end
    end
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret" or entity.type == "turret" or entity.type == "artillery-turret") then
		local orig_name = entity.name
		local turret = trackNewTurret(egcombat, entity)
		if turret.name ~= orig_name then
			script.raise_event(defines.events.script_raised_built, {mod_name = "EndgameCombat", created_entity = turret, player_index = event.player_index, stack = event.stack})
		end
		return
	end
end

local function onEntityMined(event)	
	local entity = event.entity
	local egcombat = global.egcombat
	
	removeShockwaveTurret(egcombat, entity)
	removeCannonTurret(egcombat, entity)
	removeShieldDome(egcombat, entity)
	removeLightningTurret(egcombat, entity)
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret" or entity.type == "turret" or entity.type == "artillery-turret") then
		removeTurretFromCache(egcombat, entity)
	end
end

local function onEntityRemoved(event)	
	local entity = event.entity
	local egcombat = global.egcombat
	
	removeShockwaveTurret(egcombat, entity)
	removeCannonTurret(egcombat, entity)
	removeShieldDome(egcombat, entity)
	removeLightningTurret(egcombat, entity)
	
	if entity.name == "last-stand-turret" then
		doLastStandDestruction(entity)
		return
	end
	
	if string.find(entity.name, "shield-dome-edge", 1, true) then
		getShieldDomeFromEdge(egcombat, entity, true, event.cause)
		return
	end
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret" or entity.type == "turret" or entity.type == "artillery-turret") then
		removeTurretFromCache(egcombat, entity)
		entity = deconvertTurretForRange(egcombat, entity)
		entity.die()
		return
	end
	
	doTissueDrops(egcombat, entity)
end

local function onEntityAttacked(event)	
	local entity = event.entity
	local source = event.cause
	local egcombat = global.egcombat
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret" or entity.type == "turret" or entity.type == "artillery-turret") then
		updateTurretMonitoring(egcombat, entity)
	elseif source and (source.type == "ammo-turret" or source.type == "electric-turret" or source.type == "fluid-turret" or source.type == "turret" or source.type == "artillery-turret") then
		updateTurretMonitoring(egcombat, source)
		if string.find(source.name, "lightning-turret", 1, true) then
			rechargeLightningTurret(egcombat, source)
			local offset = source.position
			local dx = entity.position.x-offset.x
			local dy = entity.position.y-offset.y
			offset.x = offset.x+dx/3.8
			offset.y = offset.y+dy/3.8-0.25
			entity.surface.create_entity({name="lightning-beam-fx", position=offset, force=source.force, target=entity, source=source})
		end
	elseif source and (entity.type == "logistic-robot" or entity.type == "construction-robot") then
		doRetaliation(source, event.final_damage_amount, entity, "robot")
	elseif source and entity.type == "electric-pole" then
		doRetaliation(source, event.final_damage_amount, entity, "electric")
	elseif source and entity.type == "radar" then
		doRetaliation(source, event.final_damage_amount, entity, "radar")
	end
end

--[[
local function onEntityMarkedDeconstruct(event)	
	local entity = event.entity
	local player = event.player_index and game.players[event.player_index] or nil
	
	if entity.name == "turret-logistic-interface" or entity.name == "dome-circuit-connection" then
		entity.cancel_deconstruction(player and player.force or entity.force)
	end
end

script.on_event(defines.events.on_marked_for_deconstruction, onEntityMarkedDeconstruct)
--]]

script.on_event(defines.events.on_entity_damaged, onEntityAttacked)

script.on_event(defines.events.on_entity_died, onEntityRemoved)
script.on_event(defines.events.script_raised_destroy, onEntityRemoved)

script.on_event(defines.events.on_player_mined_entity, onEntityMined)
script.on_event(defines.events.on_robot_mined_entity, onEntityMined)

script.on_event(defines.events.on_built_entity, onEntityAdded)
script.on_event(defines.events.on_robot_built_entity, onEntityAdded)

script.on_event(defines.events.on_research_finished, onFinishedResearch)