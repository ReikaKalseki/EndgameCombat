--require "defines"
require "util"
require "functions"
require "config"
require "constants"

function initGlobal(force)
	if not global.egcombat then
		global.egcombat = {}
	end
	if force or global.egcombat.loadTick == nil then
		global.egcombat.loadTick = false
	end
	if force or global.egcombat.placed_turrets == nil then
		global.egcombat.placed_turrets = {}
	end
	if force or global.egcombat.robot_defence == nil then
		global.egcombat.robot_defence = {}
	end
	if force or global.egcombat.chunk_cache == nil then
		global.egcombat.chunk_cache = {}
	end
	if force or global.egcombat.fleshToDeconstruct == nil then
		global.egcombat.fleshToDeconstruct = {}
	end
end

initGlobal(true)

script.on_init(function()
	initGlobal(true)
end)

script.on_configuration_changed(function()
	initGlobal(true)
end)

local function trackNewTurret(turret)
	local force = turret.force
	if force ~= game.forces.enemy then
		if global.egcombat.placed_turrets[force.name] == nil then
			global.egcombat.placed_turrets[force.name] = {}
		end
		if turret.force.technologies["turret-range-1"].researched then
			turret = convertTurretForRange(turret, getTurretRangeResearch(turret.force))
		end
		track_entity(global.egcombat.placed_turrets[force.name], turret)
		--game.print("Adding " .. turret.name .. " @ " .. turret.position.x .. ", " .. turret.position.y .. " for " .. force.name .. " to turret table; size=" .. #global.egcombat.placed_turrets[force.name])
	end
end

local function reloadRangeTech()
	if global.egcombat and global.egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if global.egcombat.placed_turrets[force.name] then
					for k,turret in pairs(global.egcombat.placed_turrets[force.name]) do
						if turret.valid then
							turret = deconvertTurretForRange(turret)
							trackNewTurret(turret)
						end
					end
				end
			end
		end
	end
	
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
			trackNewTurret(turret)
		end
	end
end

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
	if event.entity.name == "radiation-area-spawner" then
		spawnRadiationArea(event.entity)
	end
end)

script.on_event(defines.events.on_tick, function(event)
	initGlobal(false)
	if not global.egcombat.loadTick then		
		for chunk in game.surfaces["nauvis"].get_chunks() do
			table.insert(global.egcombat.chunk_cache, chunk)
		end
		
		for k,force in pairs(game.forces) do
			if global.egcombat.placed_turrets[force.name] == nil then
				global.egcombat.placed_turrets[force.name] = {}
				--game.print("Adding force " .. force.name .. " to turret table")
			end
		end
		
		global.egcombat.loadTick = true
	end
	
	if #global.egcombat.chunk_cache > 0 then
		local ticksPerChunk = 1--4
		if game.tick%ticksPerChunk == 0 then
			local chunksPerTick = 16--1
			while chunksPerTick > 0 and #global.egcombat.chunk_cache > 0 do
				chunk = global.egcombat.chunk_cache[1]
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
					trackNewTurret(turret)
				end
				
				if Config.deconstructFlesh then
					local drops = game.surfaces["nauvis"].find_entities_filtered{area = {{x1, y1}, {x2, y2}}, type="item-entity"}
					for _,item in pairs(drops) do
						if item.stack and item.stack.name == "biter-flesh" then
							table.insert(global.egcombat.fleshToDeconstruct, {item, game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
							--item.order_deconstruction(game.forces.player)
						end
					end
				end
				
				table.remove(global.egcombat.chunk_cache, 1)
				chunksPerTick = chunksPerTick-1
			end
		end
	end
	
	if global.egcombat and global.egcombat.placed_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				--game.print("Force " .. force.name .. ": " .. #global.egcombat.placed_turrets[force.name] .. " turrets placed.")
				if force.technologies["healing-alloys-1"].researched and global.egcombat.placed_turrets[force.name] then
					repairTurrets(game.surfaces["nauvis"], force)
				end
			end
		end
	end
	
	if #global.egcombat.fleshToDeconstruct > 0 then
		for i = #global.egcombat.fleshToDeconstruct,1,-1 do --iterate in reverse since removing entries
			local items = global.egcombat.fleshToDeconstruct[i]
			local item = items[1]
			local tick = items[2]
			if game.tick >= tick or not item.valid then
				if item.valid then
					item.order_deconstruction(game.forces.player)
				end
				table.remove(global.egcombat.fleshToDeconstruct, i)
			end
		end
	end
end)

function track_entity(entity_list, entity)
	--game.print(#entity_list)
    for i = #entity_list, 1, -1 do
        local e = entity_list[i]
        if not e.valid then
            table.remove(entity_list, i)
        elseif e == entity then
			--game.print("already in list?!")
            return
        end
    end

	--game.print("placing " .. entity.name)
    table.insert(entity_list, entity)
end

function repairTurrets(surface, force)
	local level = 1
	for i = #REPAIR_CHANCES, 1, -1 do
		if force.technologies["healing-alloys-" .. i].researched then
			level = i
			break
		end
	end
	--game.print(#global.egcombat.placed_turrets[force.name])
	if global.egcombat.placed_turrets[force.name] == nil then
		global.egcombat.placed_turrets[force.name] = {}
	end
	for k,turret in pairs(global.egcombat.placed_turrets[force.name]) do
		if turret.valid and math.random() < REPAIR_CHANCES[level] then
			repairTurret(turret, level)
		end
	end
end

local function onFinishedResearch(event)
	initGlobal(false)
	
	local tech = event.research.name
	if string.find(tech, "turret-range", 1, true) then
		local lvl = tonumber(string.sub(tech, -1))
		if global.egcombat.placed_turrets[event.research.force.name] == nil then
			global.egcombat.placed_turrets[event.research.force.name] = {}
		end
		for k,turret in pairs(global.egcombat.placed_turrets[event.research.force.name]) do
			if turret.valid then
				--game.print("Converting " .. turret.name .. " @ "  .. turret.position.x .. ", " .. turret.position.y .. " to tier " .. lvl)
				convertTurretForRange(turret, lvl)
			end
		end
		local turrets = game.surfaces["nauvis"].find_entities_filtered({type = "ammo-turret", force = event.research.force.name})
		for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "electric-turret", force = event.research.force.name})) do 
			table.insert(turrets, v)
		end
		for _,v in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "fluid-turret", force = event.research.force.name})) do 
			table.insert(turrets, v)
		end
		for _,turret in pairs(turrets) do
			convertTurretForRange(turret, lvl)
		end
	end
	if tech.name == "logistic-defence" then
		global.egcombat.robot_defence[event.research.force.name] = 0.8
	end
	if tech.name == "logistic-defence-2" then
		global.egcombat.robot_defence[event.research.force.name] = 1.5
	end
end

local function onEntityAdded(event)
	initGlobal(false)
	
	local entity = event.created_entity
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret") then
		trackNewTurret(entity)
		return
	end
end

local function onEntityRemoved(event)
	initGlobal(false)
	
	local entity = event.entity
	if (entity.type == "ammo-turret" or entity.type == "electric-turret" or entity.type == "fluid-turret") then
		deconvertTurretForRange(entity)
		return
	end
	
	local drops = 0
	local range = 0
	if entity.type == "unit-spawner" and (string.find(entity.name, "biter") or string.find(entity.name, "spitter")) then
		drops = math.random(5, 12)
		range = 4
	end
	if entity.type == "worm-turret" and string.find(entity.name, "worm") then
		drops = math.random(2, 5)
		range = 2
	end
	if entity.type == "unit" and (string.find(entity.name, "biter") or string.find(entity.name, "spitter")) then
		local size = 0
		if string.find(entity.name, "small") then
			size = 0.1
		end
		if string.find(entity.name, "medium") then
			size = 0.25
		end
		if string.find(entity.name, "big") then
			size = 0.5
		end
		if string.find(entity.name, "behemoth") then
			size = 1
		end
		drops = math.random() < size and (math.random() < 0.2 and math.random(1, 2) or math.random(0, 1)) or 0
		range = 1
	end
	if drops > 0 then
		for i = 1,drops do
			local pos = {entity.position.x, entity.position.y}
			pos[1] = pos[1]-range+math.random()*2*range
			pos[2] = pos[2]-range+math.random()*2*range
			entity.surface.spill_item_stack(pos, {name="biter-flesh"}, true) --does not return
			if Config.deconstructFlesh then --mark for deconstruction? Will draw robots into attack waves and turret fire... -> make config
				local drops = entity.surface.find_entities_filtered{area={{pos[1]-1,pos[2]-1},{pos[1]+1,pos[2]+1}}--[[position = pos--]], type="item-entity"}
				for _,item in pairs(drops) do
					if item.stack and item.stack.name == "biter-flesh" then
						table.insert(global.egcombat.fleshToDeconstruct, {item, game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
						--item.order_deconstruction(game.forces.player)
					end
				end
			end
		end
	end
end

script.on_event(defines.events.on_entity_died, onEntityRemoved)
--script.on_event(defines.events.on_preplayer_mined_item, onEntityRemoved)
--script.on_event(defines.events.on_robot_pre_mined, onEntityRemoved)

script.on_event(defines.events.on_built_entity, onEntityAdded)
script.on_event(defines.events.on_robot_built_entity, onEntityAdded)

script.on_event(defines.events.on_research_finished, onFinishedResearch)