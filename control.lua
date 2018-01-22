--require "defines"
require "util"
require "functions"
require "config"
require "constants"

require "shield-domes"
require "orbital-strikes"

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
	global.egcombat.dirty = markDirty
end

script.on_init(function()
	initGlobal(true)
end)

local function convertTurretCache(egcombat)
	for k,force in pairs(game.forces) do
		if egcombat.placed_turrets[force.name] == nil then
			egcombat.placed_turrets[force.name] = {}
			--game.print("Adding force " .. force.name .. " to turret table")
		end
		if #egcombat.placed_turrets[force.name] > 0 and egcombat.placed_turrets[force.name][1].surface then --if is made of pure entities, not entries containing entities
			local repl = {}
			for _,turret in pairs(egcombat.placed_turrets[force.name]) do
				local entry = createTurretEntry(turret)
				if entry then
					table.insert(repl, entry)
				end
			end
			egcombat.placed_turrets[force.name] = repl
		end
	end
end

script.on_configuration_changed(function()
	initGlobal(true)
	
	convertTurretCache(global.egcombat)
end)

local function track_turret(entity_list, turret)
	--game.print(#entity_list)
    for i = #entity_list, 1, -1 do
        local entry = entity_list[i]
        if not entry.turret.valid then
            table.remove(entity_list, i)
        elseif entry.turret == turret then
			--game.print("already in list?!")
            return
        end
    end

	--game.print("placing " .. entity.name)
    table.insert(entity_list, createTurretEntry(turret))
end

local function removeTurretFromCache(egcombat, turret)
	local entity_list = egcombat.placed_turrets[turret.force.name]
	--game.print("Reading remove of " .. turret.name .. " in force " .. turret.force.name .. ", cache is " .. (entity_list ~= nil and "non-null" or "nil"))
	if not entity_list then return end
	--game.print(#entity_list)
    for i = #entity_list, 1, -1 do
        local entry = entity_list[i]
        if (not entry.turret.valid) or entry.turret == turret or entry.turret.position == turret.position then
            table.remove(entity_list, i)
			if entry.logistic then
				local inv = entry.logistic.get_inventory(defines.inventory.chest)
				for name,count in pairs(inv.get_contents()) do
					entry.logistic.surface.spill_item_stack(entry.logistic.position, {name=name, count=count}, true)
				end
				inv.clear()
				entry.logistic.destroy()
			end
			--game.print("removing " .. entity.name)
            return
        end
    end
	--game.print("Could not find " .. entity.name)
end

local function trackNewTurret(egcombat, turret)
	local force = turret.force
	if force ~= game.forces.enemy then
		if egcombat.placed_turrets[force.name] == nil then
			egcombat.placed_turrets[force.name] = {}
		end
		if turret.force.technologies["turret-range-1"].researched then
			turret = convertTurretForRange(turret, getTurretRangeResearch(turret.force))
		end
		track_turret(egcombat.placed_turrets[force.name], turret)
	
		checkAndCacheTurret(turret, force)
		--[[
		if string.find(turret.name, "shockwave-turret", 1, true) then
			if egcombat.shockwave_turrets[force.name] == nil then
				egcombat.shockwave_turrets[force.name] = {}
			end
			table.insert(egcombat.shockwave_turrets[force.name], {turret=turret, delay=60})
			--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
		end
		--]]

		--game.print("Adding " .. turret.name .. " @ " .. turret.position.x .. ", " .. turret.position.y .. " for " .. force.name .. " to turret table; size=" .. #egcombat.placed_turrets[force.name])
	end
end

local function reloadRangeTech()
	local egcombat = global.egcombat
	if egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.placed_turrets[force.name] then
					for k,entry in pairs(egcombat.placed_turrets[force.name]) do
						if entry.turret.valid then
							entry.turret = deconvertTurretForRange(entry.turret)
							trackNewTurret(egcombat, entry.turret)
						end
					end
				end
			end
		end
	end
	
	--[[
	local turrets = game.surfaces["nauvis"].find_entities_filtered({type = "ammo-turret"})
	for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "electric-turret"})) do 
		table.insert(turrets, v)
	end
	for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "fluid-turret"})) do 
		table.insert(turrets, v)
	end
	for _,turret in pairs(turrets) do
		if turret.force ~= game.forces.enemy then
			turret = deconvertTurretForRange(turret)
			trackNewTurret(egcombat, turret)
		end
	end
	--]]
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
	
	--[[
	if #egcombat.chunk_cache > 0 then
		local ticksPerChunk = 1--4
		if game.tick%ticksPerChunk == 0 then
			local chunksPerTick = 16--1
			while chunksPerTick > 0 and #egcombat.chunk_cache > 0 do
				chunk = egcombat.chunk_cache[1]
				local x1 = chunk.x*32
				local y1 = chunk.y*32
				local x2 = x1+32
				local y2 = y1+32
				local turrets = game.surfaces["nauvis"].find_entities_filtered({area = {{x1, y1}, {x2, y2}}, type = "ammo-turret"})
				for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({area = {{x1, y1}, {x2, y2}}, type = "electric-turret"})) do 
					table.insert(turrets, v)
				end
				for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({area = {{x1, y1}, {x2, y2}}, type = "fluid-turret"})) do 
					table.insert(turrets, v)
				end
				for k,turret in pairs(turrets) do
					trackNewTurret(egcombat, turret)
				end
				
				if Config.deconstructFlesh then
					local drops = game.surfaces["nauvis"].find_entities_filtered{area = {{x1, y1}, {x2, y2}}, type="item-entity"}
					for _,item in pairs(drops) do
						if item.stack and item.stack.name == "biter-flesh" then
							table.insert(egcombat.fleshToDeconstruct, {item, game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
							--item.order_deconstruction(game.forces.player)
						end
					end
				end
				
				table.remove(egcombat.chunk_cache, 1)
				chunksPerTick = chunksPerTick-1
			end
		end
	end
	--]]
	
	if egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				--game.print("Force " .. force.name .. ": " .. #egcombat.placed_turrets[force.name] .. " turrets placed.")
				if egcombat.placed_turrets[force.name] then
					if force.technologies["healing-alloys-1"].researched then
						repairTurrets(egcombat, force)
					end
					if force.technologies["turret-logistics"].researched and game.tick%120 == 0 then
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
							tickShockwaveTurret(entry, game.tick)
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
							tickCannonTurret(entry, game.tick)
						else
							table.remove(egcombat.cannon_turrets[force.name], i)
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
							tickShieldDome(egcombat, entry, game.tick)
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
			if game.tick >= tick or not item.valid then
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
	
	if #game.players > 0 and game.tick%60 == 0 then
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
		for k,entry in pairs(egcombat.placed_turrets[force]) do
			if entry.turret.valid then
				--game.print("Converting " .. turret.name .. " @ "  .. turret.position.x .. ", " .. turret.position.y .. " to tier " .. lvl)
				convertTurretForRangeWhileKeepingSpecialCaches(entry.turret, lvl)
			end
		end
		--[[
		local turrets = game.surfaces["nauvis"].find_entities_filtered({type = "ammo-turret", force = force})
		for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "electric-turret", force = force})) do 
			table.insert(turrets, v)
		end
		for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "fluid-turret", force = force})) do 
			table.insert(turrets, v)
		end
		for _,turret in pairs(turrets) do
			convertTurretForRangeWhileKeepingSpecialCaches(turret, lvl)
		end
		--]]
	end
	if tech == "turret-logistics" then
		if egcombat.placed_turrets[force] == nil then
			egcombat.placed_turrets[force] = {}
		end
		for k,entry in pairs(egcombat.placed_turrets[force]) do
			if entry.turret.valid then
				--game.print("Creating logistic interface for " .. entry.turret.name .. " @ " .. entry.turret.position.x .. ", " .. entry.turret.position.y)
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
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret") then
		trackNewTurret(egcombat, entity)
		return
	end
end

local function onEntityMined(event)	
	local entity = event.entity
	local egcombat = global.egcombat
	
	removeShockwaveTurret(egcombat, entity)
	removeCannonTurret(egcombat, entity)
	removeShieldDome(egcombat, entity)
	--[[
	local inv = event.buffer
	if entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret" then
		if string.find(entity.name, "rangeboost") and game.entity_prototypes[getTurretBaseName(entity)].mineable_properties and #game.entity_prototypes[getTurretBaseName(entity)].mineable_properties.products > 0 then
			inv.remove({name=game.entity_prototypes[entity.name].mineable_properties.products[1].name})
			inv.insert({name=game.entity_prototypes[getTurretBaseName(entity)].mineable_properties.products[1].name})
		end
	end--]]
	
	removeTurretFromCache(egcombat, entity)
end

local function onEntityRemoved(event)	
	local entity = event.entity
	local egcombat = global.egcombat
	
	removeShockwaveTurret(egcombat, entity)
	removeCannonTurret(egcombat, entity)
	removeShieldDome(egcombat, entity)
	
	if entity.name == "last-stand-turret" then
		doLastStandDestruction(entity)
		return
	end
	
	if string.find(entity.name, "shield-dome-edge", 1, true) then
		getShieldDomeFromEdge(egcombat, entity, true, event.cause)
		return
	end
	
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret") then
		entity = deconvertTurretForRange(entity)
		removeTurretFromCache(egcombat, entity)
		return
	end
	
	doTissueDrops(egcombat, entity)
end

script.on_event(defines.events.on_entity_died, onEntityRemoved)

script.on_event(defines.events.on_player_mined_entity, onEntityMined)
script.on_event(defines.events.on_robot_mined_entity, onEntityMined)

script.on_event(defines.events.on_built_entity, onEntityAdded)
script.on_event(defines.events.on_robot_built_entity, onEntityAdded)

script.on_event(defines.events.on_research_finished, onFinishedResearch)