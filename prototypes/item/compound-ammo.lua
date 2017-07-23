require "config"
require "constants"

local ammos = {}

for name,base in pairs(data.raw.ammo) do
	if base.ammo_type.category == "bullet" then
		ammo = table.deepcopy(base)
		ammo.name = name .. "-crate"
		ammo.magazine_size = AMMO_CRATE_CAPACITY
		ammo.localised_name = {"ammo-crate.name", {"item-name." .. name}}
		ammo.icons = {
			{icon=ammo.icon}, {icon="__EndgameCombat__/graphics/icons/crated-ammo.png"}
		}
		if ammo.ammo_type.action and ammo.ammo_type.action.type == "direct" then
			if ammo.ammo_type.action.action_delivery and ammo.ammo_type.action.action_delivery.target_effects then
				for _,effect in pairs(ammo.ammo_type.action.action_delivery.target_effects) do
					if effect.type == "damage" then
						effect.damage.amount = math.ceil(effect.damage.amount*(1+math.max(5, math.min(100, Config.cratedAmmoBoost))/100)) --small (default 10%) DPS boost for using the crated ammo
					end
				end
			end
		end
		table.insert(ammos, {item=ammo, original=base})
		--log("Creating crate for ammo '" .. name .. "'")
	end
end

for _,ammo in pairs(ammos) do
	data:extend({
		ammo.item
	})
	
	data:extend({
		{
			type = "recipe",
			name = ammo.item.name,
			enabled = "true",
			energy_required = 0.2,
			category = "advanced-crafting",
			ingredients =
			{
			  {ammo.original.name, AMMO_CRATE_CAPACITY/ammo.original.magazine_size},
			  {"iron-plate", 1},
			},
			result = ammo.item.name
	  },
	})
end

for _,tech in pairs(data.raw.technology) do
	if tech.effects then
		for _,ammo in pairs(ammos) do
			for _,effect in pairs(tech.effects) do
				if effect.type == "unlock-recipe" then
					local recipe = data.raw.recipe[effect.recipe]
					if not recipe then error("Tech set to unlock recipe '" .. effect.recipe .. "', which does not exist?!") end
					local output = recipe.result
					if recipe.normal and not output then
						output = recipe.normal.result
					end
					--if not output then error("Tech set to unlock recipe '" .. effect.recipe .. "', which has a null output?!") end --apparently allowed
					if output then
						if ammo.original.name == output then
							table.insert(tech.effects, {type="unlock-recipe", recipe=ammo.item.name})
							data.raw.recipe[ammo.item.name].enabled = "false"
							--log("Adding ammo '" .. ammo.original.name .. "' crate unlock to tech " .. tech.name)
							break
						end
					end
				end
			end
		end
	end
end