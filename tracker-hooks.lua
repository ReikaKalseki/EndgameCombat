require "__DragonIndustries__/entitytracker"

require "functions"
require "turretai"

local function tickShockwaveTurrets(egcombat, tick)
	if egcombat.shockwave_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.shockwave_turrets[force.name] then
					for i, entry in ipairs(egcombat.shockwave_turrets[force.name]) do
						if entry.turret.valid then
							tickShockwaveTurret(egcombat, entry, tick)
						else
							table.remove(egcombat.shockwave_turrets[force.name], i)
						end
					end
				end
			end
		end
	end
end

local function tickLightningTurrets(egcombat, tick)
	if egcombat.lightning_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.lightning_turrets[force.name] then
					for unit, entry in pairs(egcombat.lightning_turrets[force.name]) do
						if entry.turret.valid then
							tickLightningTurret(egcombat, entry, tick)
						else
							egcombat.lightning_turrets[force.name][unit] = nil
						end
					end
				end
			end
		end
	end
end

local function tickCannonTurrets(egcombat, tick)
	if egcombat.cannon_turrets then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.cannon_turrets[force.name] then
					for i, entry in ipairs(egcombat.cannon_turrets[force.name]) do
						if entry.turret.valid then
							tickCannonTurret(egcombat, entry, tick)
						else
							table.remove(egcombat.cannon_turrets[force.name], i)
						end
					end
				end
			end
		end
	end
end

local function tickShieldDomes(egcombat, tick)
	if egcombat.shield_domes then
		for k,force in pairs(game.forces) do
			if force ~= game.forces.enemy then
				if egcombat.shield_domes[force.name] then
					for unit, entry in pairs(egcombat.shield_domes[force.name]) do
						if entry.dome.valid then
							tickShieldDome(egcombat, entry, tick)
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
end

function getGlobal()
	return global.egcombat
end

addMatcherTracker("shockwave-turret",		nil,	removeShockwaveTurret,		tickShockwaveTurrets,		"egcombat",	getGlobal())
addMatcherTracker("lightning-turret",		nil,	removeLightningTurret,		tickLightningTurrets,		"egcombat",	getGlobal())
addMatcherTracker("cannon-turret",			nil,	removeCannonTurret,			tickCannonTurrets,			"egcombat",	getGlobal())
addMatcherTracker("shield-dome",			nil,	removeShieldDome,			tickShieldDomes,			"egcombat",	getGlobal())