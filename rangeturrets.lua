require "constants"
require "plasmabeam"
require "functions"

function getTurretRangeBoost(force)
	local level = getTurretRangeResearch(force)
	return level > 0 and TURRET_RANGE_BOOST_SUMS[level] or 0
end

function getTurretRangeResearch(force)
	if not force.technologies["turret-range-1"].researched then return 0 end
	local level = 1
	for i = #TURRET_RANGE_BOOSTS, 1, -1 do
		if force.technologies["turret-range-" .. i].researched then
			level = i
			break
		end
	end
	return level
end

function getTurretBaseNameByName(name)
	if string.find(name, "-rangeboost-", 1, true) then
		local n = string.find(name, "rangeboost-10", 1, true) and 3 or 2
		name = string.sub(name, 1, -string.len("-rangeboost-")-n) --aka Java substring(0, length()-"-rangeboost-".length()-n)
	end
	return name
end

function getTurretBaseName(turret)
	return getTurretBaseNameByName(turret.name)
end

local function replaceTurretKeepingContents(turret, newname)
	local surf = turret.surface
	local pos = {turret.position.x, turret.position.y}
	local dir = turret.direction
	local h = turret.health
	local f = turret.force
	local e = turret.energy
	local dmg = turret.damage_dealt
	local kills = turret.kills
	local user = turret.last_user
	local inv = turret.get_inventory(defines.inventory.turret_ammo)
	local items = nil
	if inv ~= nil then
		items = {}
		for i = 1,#inv do
			local stack = inv[i]
			if stack and stack.valid_for_read then
				items[#items+1] = {item = stack.name, num = stack.count}
			else
				items[#items+1] = nil
			end
		end
	end
	local fluids = nil
	local fbox = turret.fluidbox
	if fbox ~= nil then
		fluids = {}
		for i = 1,#fbox do
			local stack = fbox[i]
			if stack then
				fluids[#fluids+1] = {fluid = stack.name, amount = stack.amount, temp = stack.temperature}
			else
				fluids[#fluids+1] = nil
			end
		end
	end
	turret.destroy()
	local repl = surf.create_entity{name=newname, position=pos, direction=dir, force=f, fast_replace=true, spill=false}
	repl.energy = e
	repl.kills = kills
	repl.damage_dealt = dmg
	repl.health = h
	if user then
		repl.last_user = user
	end
	if items ~= nil then
		for i = 1,#items do
			local stack = items[i]
			if stack ~= nil then
				repl.insert({name = stack.item, count = stack.num})
			end
		end
	end
	if fluids ~= nil then
		for i = 1,#fluids do
			local stack = fluids[i]
			if stack ~= nil then
				repl.fluidbox[i] = {name = stack.fluid, amount = stack.amount, temperature = stack.temp}
			end
		end
	end
	if repl.health == 0 then --fixes a "replacement on death with base turret" bug
		repl.die()
	end
	return repl
end

function replaceTurretInCache(egcombat, force, new, oldid, entry_fallback)
	if new.unit_number == oldid then  error("You cannot replace a turret with itself! @ " .. debug.traceback()) end
	--game.print("Replacing turret cache entry from " .. oldid .. " to " .. new.unit_number)
	local entry = egcombat.placed_turrets[force.name][oldid]
	if entry_fallback and not entry then
		entry = entry_fallback
	end
	egcombat.placed_turrets[force.name][new.unit_number] = entry
	egcombat.placed_turrets[force.name][oldid] = nil
end

function convertTurretForRange(egcombat, turret, level, recache)
	if level == 0 then return turret end
	if not turret.valid then return turret end
	if not turret.surface.valid then return turret end
	local cur = tonumber(string.match(turret.name, "%d+"))
	--game.print("Changing rangeboost from " .. (cur and cur or 0) .. " to " .. level)
	local n = getTurretBaseName(turret) .. "-rangeboost-" .. level
	if game.entity_prototypes[n] then
		local id = turret.unit_number
		local force = turret.force
		local ret = replaceTurretKeepingContents(turret, n)
		if recache then
			replaceTurretInCache(egcombat, force, ret, id)
		end
		return ret
	else
		return turret --if does not have a counterpart (technical entity), just return the original
	end
end

function convertTurretForRangeWhileKeepingSpecialCaches(egcombat, turret, level, recache)
	local ret = convertTurretForRange(egcombat, turret, level, recache)
	local force = ret.force
	checkAndCacheTurret(egcombat, ret, force)
	--game.print("conversion finished, with turret " .. ret.unit_number .. " at level " .. level)
	return ret
end

function deconvertTurretForRange(egcombat, turret)
	if not turret.valid then return turret end
	if not turret.surface.valid then return turret end
	if string.find(turret.name, "-rangeboost-", 1, true) then
		local n = getTurretBaseName(turret)
		return replaceTurretKeepingContents(turret, n)
	end
	return turret
end

function upgradeTurretForRange(egcombat, turret, level)
	local cur = tonumber(string.match(turret.name, "%d+"))
	if cur == level then
		--game.print("Not re-upgrading " .. turret.name .. "; it is already level " .. level)
		return turret
	end
	turret = deconvertTurretForRange(egcombat, turret)
	return convertTurretForRange(egcombat, turret, level, false)
end

function isTechnicalTurret(name)
	if name == "AlienControlStation_Area" then
		return true
	end
	return false
end