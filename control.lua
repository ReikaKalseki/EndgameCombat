--require "defines"
require "util"
require "functions"
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