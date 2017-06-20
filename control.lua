--require "defines"
require "util"
require "functions"

local loadTick = false

local placed_turrets = {}
local chunk_cache = {}

--[[
script.on_load(function()
	if global.EndgameCombatVars == nil then
		global.EndgameCombatVars = {}
	end
	if global.EndgameCombatVars.robotDefenceLevelBoostFactor == nil then
		global.EndgameCombatVars.robotDefenceLevelBoostFactor = 0
	end
end)

script.on_event(defines.events.on_research_finished, function(event)
	if event.research.name == "logistic-defence" then
		global.EndgameCombatVars.robotDefenceLevelBoostFactor = 1
	end
	if event.research.name == "logistic-defence-2" then
		global.EndgameCombatVars.robotDefenceLevelBoostFactor = 1.5
	end
end)
--]]

script.on_event(defines.events.on_trigger_created_entity, function(event)
	if event.entity.name == "fire-area-spawner" then
		spawnFireArea(event.entity)
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
    if event.created_entity.type == "electric-turret" or event.created_entity.type == "ammo-turret" then
        track_entity(--[[global.EndgameCombatVars.--]]placed_turrets[event.created_entity.force.name], event.created_entity)
    end
	--game.print(event.created_entity.type .. " " .. #--[[global.EndgameCombatVars.--]]placed_turrets[event.created_entity.force.name])
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
    if event.created_entity.type == "electric-turret" or event.created_entity.type == "ammo-turret" then
        track_entity(--[[global.EndgameCombatVars.--]]placed_turrets[event.created_entity.force.name], event.created_entity)
    end
end)

script.on_event(defines.events.on_tick, function(event)
	if not loadTick then
	--[[
		if global.EndgameCombatVars == nil then
			global.EndgameCombatVars = {}
		end
		if global.EndgameCombatVars.placed_turrets == nil then
			global.EndgameCombatVars.placed_turrets = {}
		end
		--]]
		
		--[[
		local turrets = game.surfaces["nauvis"].find_entities_filtered({type = "turret"})
		for k,turret in pairs(turrets) do
			local force = turret.force
			if --]]--[[global.EndgameCombatVars.--]]--[[placed_turrets[force.name] == nil then--]]
				--[[global.EndgameCombatVars.--]]--[[placed_turrets[force.name] = {}
			end
			track_entity(--]]--[[global.EndgameCombatVars.--]]--[[placed_turrets[force.name], turret)
		end
		--]]
		
		for chunk in game.surfaces["nauvis"].get_chunks() do
			table.insert(chunk_cache, chunk)
		end
		
		for k,force in pairs(game.forces) do
			if --[[global.EndgameCombatVars.--]]placed_turrets[force.name] == nil then
				--[[global.EndgameCombatVars.--]]placed_turrets[force.name] = {}
			end
		end
		
		loadTick = true
	end
	
	if game.tick%4 == 0 and #chunk_cache > 0 then
		chunk = chunk_cache[1]
		local x1 = chunk.x*32
		local y1 = chunk.y*32
		local x2 = x1+32
		local y2 = y1+32
		local turrets = game.surfaces["nauvis"].find_entities_filtered({area = {{x1, y1}, {x2, y2}}, type = "turret"})
		for k,turret in pairs(turrets) do
			local force = turret.force
			if --[[global.EndgameCombatVars.--]]placed_turrets[force.name] == nil then
				--[[global.EndgameCombatVars.--]]placed_turrets[force.name] = {}
			end
			track_entity(--[[global.EndgameCombatVars.--]]placed_turrets[force.name], turret)
		end
		table.remove(chunk_cache, 1)
	end
	
	--if global.EndgameCombatVars and global.EndgameCombatVars.placed_turrets then
		for k,force in pairs(game.forces) do
			if force.technologies["healing-alloys-1"].researched and --[[global.EndgameCombatVars.--]]placed_turrets[force.name] then
				--game.print(force.name)
				repairTurrets(game.surfaces["nauvis"], force)
			end
		end
	--end
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
	for i = 5, 1, -1 do
		if force.technologies["healing-alloys-" .. i].researched then
			level = i
			break
		end
	end
	--game.print(#--[[global.EndgameCombatVars.--]]placed_turrets[force.name])
	for k,turret in pairs(--[[global.EndgameCombatVars.--]]placed_turrets[force.name]) do
		if turret.valid and math.random() < REPAIR_CHANCES[level] then
			repairTurret(turret, level)
		end
	end
end