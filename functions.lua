require "constants"
require "plasmabeam"

require "__DragonIndustries__.mathhelper"
require "__DragonIndustries__.arrays"
require "__DragonIndustries__.cloning"
require "__DragonIndustries__.strings"
require "__DragonIndustries__.entities"

local function createCapsuleDamage(cloud, name, dtype)
	local dat = CLOUD_DAMAGE_PROFILES[name]
	if not dat then error("Capsule type '" .. name .. "' has no specified damage profile!") end
	cloud.created_effect[2].distance = cloud.created_effect[2].distance*dat.radius
	if dat.radius >= 1 then
		cloud.created_effect[2].cluster_count = math.ceil(cloud.created_effect[2].cluster_count*dat.radius*dat.radius)
	end
	cloud.action.action_delivery.target_effects.action.radius = cloud.action.action_delivery.target_effects.action.radius*dat.radius
	cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.type = dtype
	local newdmg = cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount
	newdmg = newdmg*dat.dps*dat.tickrate
	cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount = newdmg
	table.insert(cloud.action.action_delivery.target_effects.action.entity_flags, "placeable-enemy")
	cloud.action_cooldown = cloud.action_cooldown*dat.tickrate
	cloud.duration = dat.dps > 0 and cloud.duration*dat.total/dat.dps or 0
	cloud.animation.scale = (cloud.animation.scale and cloud.animation.scale or 1)*dat.radius
	cloud.fade_away_duration = math.min(cloud.fade_away_duration, math.floor(cloud.duration/2.5))
	cloud.spread_duration = math.min(cloud.spread_duration, math.floor(cloud.duration/2.5))
	cloud.fade_in_duration = cloud.spread_duration
end;

function createDerivedCapsule(typename, range, cooldown, duration, color, trigger)
	local newname = typename .. "-capsule"
	local ret = copyObject("capsule", "poison-capsule", newname)
	ret.icon = "__EndgameCombat__/graphics/icons/" .. newname .. ".png"
	ret.icon_size = 32
	ret.icon_mipmaps = 0
	if range then
		ret.capsule_action.attack_parameters.range = range
	end
	if cooldown then
		ret.capsule_action.attack_parameters.cooldown = cooldown
	end
	local effects = ret.capsule_action.attack_parameters.ammo_type.action
	if effects.action_delivery then
		effects.action_delivery.projectile = newname
	else
		effects[1].action_delivery.projectile = newname
	end
	local proj = copyObject("projectile", "poison-capsule", newname)
	local cloudname = typename .. "-capsule-cloud"
	proj.action[1].action_delivery.target_effects[1].entity_name = cloudname
	if trigger then
		proj.action[1].action_delivery.target_effects[1].trigger_created_entity = "true"
	end
	replaceSpritesDynamic("EndgameCombat", "poison-cloud", proj)
	replaceSpritesDynamic("EndgameCombat", "poison-capsule", proj)
	replaceSpritesDynamic("EndgameCombat", "poison-capsule", ret)
	local cloud = copyObject("smoke-with-trigger", "poison-cloud", cloudname)
	local clouddummy = copyObject("smoke-with-trigger", "poison-cloud-visual-dummy", cloudname .. "-visual-dummy")
	cloud.duration = 60 * duration
	if cloud.duration < 120 then
		cloud.cyclic = false
		clouddummy.cyclic = false
	end
	cloud.spread_duration = 10
	cloud.color = color	
	cloud.show_when_smoke_off = true
	clouddummy.spread_duration = 10
	clouddummy.color = color	
	clouddummy.show_when_smoke_off = true
	cloud.created_effect[1].action_delivery.target_effects[1].entity_name = clouddummy.name
	cloud.created_effect[2].action_delivery.target_effects[1].entity_name = clouddummy.name
	createCapsuleDamage(cloud, typename, typename)
	if cloud.duration <= 0 then
		cloud.duration = 1
		cloud.spread_duration = 0
		cloud.fade_away_duration = 0
	end
	clouddummy.duration = cloud.duration
	--log("Created capsule " .. newname .. " with cloud " .. serpent.block(cloud))
	--log(serpent.block(proj))
	--log(serpent.block(ret))
	--log(serpent.block(clouddummy))
	clouddummy.fade_away_duration = math.min(clouddummy.fade_away_duration, math.floor(clouddummy.duration/2.5))
	clouddummy.spread_duration = math.min(clouddummy.spread_duration, math.floor(clouddummy.duration/2.5))
	clouddummy.fade_in_duration = clouddummy.spread_duration
	return {item = ret, projectile = proj, cloud = cloud, clouddummy = clouddummy}
end

local function createWallPictures(name)
    local pictures =
    {
      single =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-single.png",
            priority = "extra-high",
            width = 22,
            height = 42,
            shift = {0, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-single-shadow.png",
            priority = "extra-high",
            width = 47,
            height = 32,
            shift = {0.359375, 0.5},
            draw_as_shadow = true
          }
        }
      },
      straight_vertical =
      {
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-1.png",
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-shadow.png",
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-2.png",
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-shadow.png",
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-3.png",
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-vertical-shadow.png",
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        }
      },
      straight_horizontal =
      {
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-1.png",
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-shadow.png",
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-2.png",
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-shadow.png",
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-3.png",
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-straight-horizontal-shadow.png",
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        }
      },
      corner_right_down =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-corner-right-down.png",
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {0.078125, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-corner-right-down-shadow.png",
            priority = "extra-high",
            width = 53,
            height = 61,
            shift = {0.484375, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      corner_left_down =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-corner-left-down.png",
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {-0.078125, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-corner-left-down-shadow.png",
            priority = "extra-high",
            width = 53,
            height = 60,
            shift = {0.328125, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      t_up =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-t-down.png",
            priority = "extra-high",
            width = 32,
            height = 42,
            shift = {0, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-t-down-shadow.png",
            priority = "extra-high",
            width = 71,
            height = 61,
            shift = {0.546875, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      ending_right =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-ending-right.png",
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {0.078125, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-ending-right-shadow.png",
            priority = "extra-high",
            width = 53,
            height = 32,
            shift = {0.484375, 0.5},
            draw_as_shadow = true
          }
        }
      },
      ending_left =
      {
        layers =
        {
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-ending-left.png",
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {-0.078125, -0.15625}
          },
          {
            filename = "__EndgameCombat__/graphics/entity/" .. name .. "/wall-ending-left-shadow.png",
            priority = "extra-high",
            width = 53,
            height = 32,
            shift = {0.328125, 0.5},
            draw_as_shadow = true
          }
        }
      }
    }
	return pictures
end

function createDerivedWall(newname, health, attackparams, resistances, repairSpeed)
	local entity = copyObject("wall", "stone-wall", newname)
	local item = copyObject("item", "stone-wall", newname)
	item.icon_size = 32
	item.icon = "__EndgameCombat__/graphics/icons/" .. newname .. ".png"
	item.icon_mipmaps = 0
	entity.icon_size = item.icon_size
	entity.icon_mipmaps = item.icon_mipmaps
	entity.icon = item.icon
	entity.max_health = health
	if attackparams then
		entity.attack_reaction = {{
			range = 2,
			damage_type = "physical",
			reaction_modifier = attackparams.modifier,
			action = {
				type = "direct",
				action_delivery = {
					type = "instant",
					target_effects = {
						type = "damage",
						damage = {amount = attackparams.amount, type = attackparams.type}
					}
				}
			},
		}}
	end
	if repairSpeed then
		entity.repair_speed_modifier = repairSpeed
	end
	if resistances then
		entity.resistances = resistances
	end
	entity.pictures = createWallPictures(entity.name)
	return {entity=entity, item=item}
end

function createDerivedTurret(category, name, newname)
	local entity = copyObject(category, name, newname)
	local item = copyObject("item", name, newname)
	reparentSprites("base", "EndgameCombat", entity)
	reparentSprites("base", "EndgameCombat", item)
	entity.icon_size = 32
	item.icon_size = 32
	item.icon = "__EndgameCombat__/graphics/icons/" .. newname .. ".png"
	entity.icon = item.icon
	return {entity=entity, item=item}
end

function Modify_Power(obj, factor)
	local pow = obj.max_power
	local num = string.sub(pow, 1, -3)
	local endmult = string.sub(pow, -2, -1)
	local newpow = num*factor
	obj.max_power = newpow .. endmult
end

function changeAmmoDamage(ammo, damages)
	local effects = data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects
	local repl = {}
	for _,effect in pairs(effects) do
		if effect.type ~= "damage" then
			table.insert(repl, effect)
		end
	end
	data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects = repl
	for i = 1,#damages,2 do
		local type_ = damages[i]
		local amt = damages[i+1]
		table.insert(data.raw.ammo[ammo].ammo_type.action.action_delivery.target_effects, {type = "damage", damage = {amount = amt, type = type_}})
	end
end

local function getRetaliationLevel(force, type)
	local name = type .. "-retaliation-"
	local ret = 0
	for lvl,val in pairs(RETALIATIONS[type]) do
		local name2 = name .. lvl
		if force.technologies[name2].researched then
			ret = math.max(ret, lvl)
		end
	end
	return ret
end

function doRetaliation(attacker, raw, target, type)
	local force = target.force
	if attacker.force == force then return end--friendly fire
	local lvl = getRetaliationLevel(force, type)
	if lvl <= 0 then return end
	local amt = RETALIATIONS[type][lvl].func(raw, attacker.prototype.max_health)
	--game.print("Found level " .. lvl .. " for type " .. type .. ": " .. raw .. " > " .. amt)
	attacker.surface.create_entity{name = "shockwave-beam", position = target.position, source = target, target = attacker, force = force}
	for _,player in pairs(game.players) do
		player.play_sound{path="shockwave-sound", position=attacker.position, volume_modifier=1}
	end
	attacker.damage(amt, force, "electric")
end

function getPositionForBPEntity(entity)
	local position = entity.position
	
	if (entity.has_flag("placeable-off-grid")) then
		return position
	end

	local buildingGridBitShift = entity.building_grid_bit_shift
	local tiledResult = position
	tiledResult = roundToGridBitShift(tiledResult, buildingGridBitShift)
	local result = {x=tiledResult.x, y=tiledResult.y}
	result.x = result.x + bit32.lshift(1, buildingGridBitShift) * 0.5
	result.y = result.y + bit32.lshift(1, buildingGridBitShift) * 0.5
	return result
end

function cleanTissueNearPlayer(egcombat, player)
	local r = 32
	local drops = player.surface.find_entities_filtered{area={{player.position.x-r, player.position.y-r}, {player.position.x+r, player.position.y+r}}, type="item-entity"}
	for _,item in pairs(drops) do
		if item.stack and item.stack.valid_for_read and item.stack.name == "biter-flesh" and not (item.to_be_deconstructed(game.forces.player)) then
			table.insert(egcombat.fleshToDeconstruct, {entity=item, time=game.tick+Config.deconstructFleshTimer*60}) --10s delay by default; 60*seconds
			--item.order_deconstruction(game.forces.player)
		end
	end
end

function doTissueDrops(egcombat, entity)
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
	if entity.type == "unit" and Config.bitersDropFlesh and (string.find(entity.name, "biter") or string.find(entity.name, "spitter")) then
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
		range = 0.75
	end
	--game.print("Attempting " .. drops .. " drops.")
	if drops > 0 then
		local evo = game.forces.enemy.evolution_factor
		local droptime = game.tick+Config.deconstructFleshTimer*60*(1+evo*3)
		for i = 1,drops do
			local pos = {x = entity.position.x, y = entity.position.y}
			pos.x = pos.x-range+math.random()*2*range
			pos.y = pos.y-range+math.random()*2*range
			local r = 0.25--1
			local box = {{pos.x-r,pos.y-r},{pos.x+r,pos.y+r}}
			local belts = entity.surface.find_entities_filtered{area=box, type={"transport-belt", "underground-belt", "loader", "item-entity"}, limit = 1}
			if belts and #belts > 0 then --do not spill items on belts, or on top of each other
				drops = math.min(drops+1, 20) --add a retry, within a limit
				--game.print("Failed drop " .. i .. ", trying again...")
			else
				--game.print("Dropping drop @ " .. pos.x .. ", " .. pos.y)
				entity.surface.spill_item_stack(pos, {name="biter-flesh"}, true) --does not return
				if Config.deconstructFlesh then --mark for deconstruction? Will draw robots into attack waves and turret fire... -> make config
					local drops = entity.surface.find_entities_filtered{area=box--[[position = pos--]], type="item-entity"}
					for _,item in pairs(drops) do
						if item.stack and item.stack.valid_for_read and item.stack.name == "biter-flesh" then
							table.insert(egcombat.fleshToDeconstruct, {entity=item, time=droptime}) --10s delay by default; 60*seconds
							--item.order_deconstruction(game.forces.player)
						end
					end
				end
			end
		end
	end
end

function spawnRadiationArea(entity)
	local nfire = 1600
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(2/3)*RADIATION_RADIUS
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		local lifevar = RADIATION_LIFES[math.random(1, #RADIATION_LIFES)]
		--game.print("Selecting lifevar " .. lifevar)
		local neighbors = entity.surface.find_entities_filtered({area = {{fx-2, fy-2}, {fx+2, fy+2}}, type = "fire"})
		if #neighbors <= 1 then
			entity.surface.create_entity{name = "radiation-fire-" .. lifevar, position = {x = fx, y = fy}, force = game.forces.neutral}

			if math.random(0, 2) ~= 0 then
				local list = {["small"] = 4, ["medium"] = 7, ["big"] = 10, ["huge"] = 8}
				local size = getCustomWeightedRandom(list)
				entity.surface.create_entity{name = "fallout-" .. size .. "-" .. math.random(0, 6), position = {x = fx, y = fy}, force = game.forces.neutral}
			end
		end
	end
end

function spawnCapsuleFireArea(entity)
	local nfire = math.random(1, 5)
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(1/2)*4
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		entity.surface.create_entity{name = "big-fire-flame-napalm", position = {x = fx, y = fy}, force = game.forces.neutral}
	end
end

function spawnFireArea(entity)
	local nfire = 480+math.random(160) --was 180/160 then 240/220 then 240/360, then 320/320
	for i = 1, nfire do
		local ang = math.random()*2*math.pi
		local r = (math.random())^(1/2)*NAPALM_RADIUS
		if math.random() < 0.5 then
			r = r*0.67
		end
		local dx = r*math.cos(ang)
		local dy = r*math.sin(ang)
		local fx = entity.position.x+dx
		local fy = entity.position.y+dy
		entity.surface.create_entity{name = "big-fire-flame-napalm", position = {x = fx, y = fy}, force = game.forces.neutral}
	end
end

function removeShockwaveTurret(egcombat, entity)
	if string.find(entity.name, "shockwave-turret", 1, true) and egcombat.shockwave_turrets[entity.force.name] then
		for i, entry in ipairs(egcombat.shockwave_turrets[entity.force.name]) do
			if entry.turret.position.x == entity.position.x and entry.turret.position.y == entity.position.y then
				table.remove(egcombat.shockwave_turrets[entity.force.name], i)
				break
			end
		end
	end
end

function removeCannonTurret(egcombat, entity)
	if string.find(entity.name, "cannon-turret", 1, true) and egcombat.cannon_turrets[entity.force.name] then
		for i, entry in ipairs(egcombat.cannon_turrets[entity.force.name]) do
			if entry.turret.position.x == entity.position.x and entry.turret.position.y == entity.position.y then
				table.remove(egcombat.cannon_turrets[entity.force.name], i)
				break
			end
		end
	end
end

function removeShieldDome(egcombat, entity)
	if string.find(entity.name, "shield-dome", 1, true) and egcombat.shield_domes[entity.force.name] and (not string.find(entity.name, "edge")) then
		local entry = egcombat.shield_domes[entity.force.name][entity.unit_number]
		if not entry then game.print("Dome " .. entity.name .. " #" .. entity.unit_number .. " with no entry @ " .. entity.position.x .. ", " .. entity.position.y .. " ?") return end
		for biter,edge in pairs(entry.edges) do
			edge.entity.destroy()
			if edge.effect and edge.effect.valid then
				edge.effect.destroy()
			end
			if edge.light and edge.light.valid then
				edge.light.destroy()
			end
		end
		if entry.circuit then
			entry.circuit.disconnect_neighbour(defines.wire_type.red)
			entry.circuit.disconnect_neighbour(defines.wire_type.green)
			entry.circuit.destroy()
		end
		egcombat.shield_domes[entity.force.name][entity.unit_number] = nil
	end
end

function removeLightningTurret(egcombat, entity)
	if string.find(entity.name, "lightning-turret", 1, true) and egcombat.lightning_turrets[entity.force.name] then
		egcombat.lightning_turrets[entity.force.name][entity.unit_number] = nil
	end
end

function checkAndCacheTurret(egcombat, turret, force)
	if string.find(turret.name, "shockwave-turret", 1, true) then
		if egcombat.shockwave_turrets[force.name] == nil then
			egcombat.shockwave_turrets[force.name] = {}
		end
		table.insert(egcombat.shockwave_turrets[force.name], {turret=turret, delay=60})
		--game.print("Shockwave turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "cannon-turret", 1, true) then
		if egcombat.cannon_turrets[force.name] == nil then
			egcombat.cannon_turrets[force.name] = {}
		end
		table.insert(egcombat.cannon_turrets[force.name], {turret=turret, delay=90})
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "lightning-turret", 1, true) then
		if egcombat.lightning_turrets[force.name] == nil then
			egcombat.lightning_turrets[force.name] = {}
		end
		egcombat.lightning_turrets[force.name][turret.unit_number] = {turret=turret, delay=90}
		rechargeLightningTurret(egcombat, turret)
		--game.print("Lightning turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
	
	if string.find(turret.name, "shield-dome", 1, true) then
		if egcombat.shield_domes[force.name] == nil then
			egcombat.shield_domes[force.name] = {}
		end
		local idx = string.sub(turret.name, 1, -string.len("shield-dome")-2) --is the name
		local conn = turret.surface.create_entity({name="dome-circuit-connection", position = {turret.position.x-0.125, turret.position.y+0.25}, force=force})
		conn.operable = false
		egcombat.shield_domes[force.name][turret.unit_number] = {dome=turret, circuit = conn, delay = 60, index = idx, current_shield = 0, strength_factor = getCurrentDomeStrengthFactor(force), cost_factor = getCurrentDomeCostFactor(force), edges = {}}
		--game.print("Cannon turret @ " .. turret.position.x .. ", " .. turret.position.y)
	end
end

function isTechnicalTurret(name)
	if name == "AlienControlStation_Area" then
		return true
	end
	if name == "se-meteor-defence-container" or name == "se-meteor-point-defence-container" then
		return true
	end
	return false
end

function createLogisticInterface(turret)
	if isTechnicalTurret(turret.name) then return false end --technical entity
	local force = turret.force
	if (turret.type == "ammo-turret" or turret.type == "artillery-turret") and force.technologies["turret-logistics"].researched and #turret.get_inventory(defines.inventory.turret_ammo) > 0 then
		local pos = turret.position
		local surface = turret.surface
		local box = turret.prototype.collision_box
		local dx = math.ceil((box.right_bottom.x-box.left_top.x)-1)/2
		local dy = math.ceil((box.right_bottom.y-box.left_top.y)-1)/2
		local logi = surface.create_entity({name="turret-logistic-interface", position={pos.x+dx, pos.y+dy}, force=force})
		return logi
	end
	return nil
end

function createTurretEntry(turret)
	if not turret.valid then return nil end
	local ret = {type = turret.type, turret=turret, logistic=createLogisticInterface(turret)}
	return ret
end

function removeTurretFromCache(egcombat, turret)
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

local function track_turret(entity_list, turret)
    entity_list[turret.unit_number] = createTurretEntry(turret)
end

function trackNewTurret(egcombat, turret)
	local force = turret.force
	if force ~= game.forces.enemy then
		if egcombat.placed_turrets[force.name] == nil then
			egcombat.placed_turrets[force.name] = {}
		end
		if turret.force.technologies["turret-range-1"].researched then
			turret = convertTurretForRange(egcombat, turret, getTurretRangeResearch(egcombat, turret.force), true)
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