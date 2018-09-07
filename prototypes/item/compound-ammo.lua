require "config"
require "constants"

local ammos = {}

for name,base in pairs(data.raw.ammo) do
	if base.ammo_type.category == "bullet" then
		ammo = table.deepcopy(base)
		ammo.name = name .. "-crate"
		ammo.magazine_size = AMMO_CRATE_CAPACITY
		ammo.stack_size = 100 --halve the total stack size, but still 5x as much ammo per slot
		ammo.localised_name = {"ammo-crate.name", {"item-name." .. name}}
		ammo.icons = {
			{icon=ammo.icon}, {icon="__EndgameCombat__/graphics/icons/crated-ammo.png"}
		}
		--do damage behavior later
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
			category = data.raw["recipe-category"]["non-manual-crafting"] and "non-manual-crafting" or "advanced-crafting",
			ingredients =
			{
			  {ammo.original.name, AMMO_CRATE_CAPACITY/ammo.original.magazine_size},
			  {"iron-plate", 1},
			},
			result = ammo.item.name,
			--allow_decomposition = false,
			allow_as_intermediate = false
		},
		{
			type = "recipe",
			name = ammo.item.name .. "-unpacking",
			enabled = "true",
			energy_required = 0.05,
			ingredients =
			{
			  {ammo.item.name, 1},
			},
			result = ammo.original.name, 
			result_count = AMMO_CRATE_CAPACITY/ammo.original.magazine_size,
			allow_decomposition = false,
			allow_as_intermediate = false
		},
	})
end

for _,tech in pairs(data.raw.technology) do
	if tech.effects then
		for _,ammo in pairs(ammos) do
			for _,effect in pairs(tech.effects) do
				if effect.type == "unlock-recipe" then
					local recipe = data.raw.recipe[effect.recipe]
					if not recipe then Config.error("Tech " .. tech.name .. " set to unlock recipe '" .. effect.recipe .. "', which does not exist?! This is a bug in that mod!") end
					if recipe then
						local output = recipe.result
						if recipe.normal and not output then
							output = recipe.normal.result
						end
						--if not output then Config.error("Tech set to unlock recipe '" .. effect.recipe .. "', which has a null output?!") end --apparently allowed
						if output then
							if ammo.original.name == output then
								table.insert(tech.effects, {type="unlock-recipe", recipe=ammo.item.name})
								table.insert(tech.effects, {type="unlock-recipe", recipe=ammo.item.name .. "-unpacking"})
								data.raw.recipe[ammo.item.name].enabled = "false"
								data.raw.recipe[ammo.item.name .. "-unpacking"].enabled = "false"
								--log("Adding ammo '" .. ammo.original.name .. "' crate unlock to tech " .. tech.name)
								break
							end
						end
					end
				end
			end
		end
	end
end