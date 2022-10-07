require "config"

for name,ammo in pairs(data.raw.ammo) do
	if ammo.magazine_size == AMMO_CRATE_CAPACITY and ammo.stack_size == 100 and string.find(ammo.name, "crate") then
		local id = string.sub(ammo.name, 1, -string.len("-crate")-1)
		--log(id)
		local base = data.raw.ammo[id]
		ammo.ammo_type.action = table.deepcopy(base.ammo_type.action)
		if ammo.ammo_type.action and ammo.ammo_type.action.type == "direct" then
			if ammo.ammo_type.action.action_delivery and ammo.ammo_type.action.action_delivery.target_effects then
				local f = (1+math.max(5, math.min(100, Config.cratedAmmoBoost))/100)
				log("Applying " .. f .. "x damage boost to crated " .. id)
				for _,effect in pairs(ammo.ammo_type.action.action_delivery.target_effects) do
					if effect.type == "damage" then
						local new = effect.damage.amount*f--math.ceil(effect.damage.amount*f) --can be a float
						log("Damage type '" .. effect.damage.type .. "' amount changed from " .. effect.damage.amount .. " to " .. new)
						effect.damage.amount = new --small (default 10%) DPS boost for using the crated ammo
					end
				end
			end
		end
	end
end

if data.raw.item["advanced-processing-unit"] then
	replaceItemInRecipe("lightning-turret", "processing-unit", "advanced-processing-unit", 1, false)
end

--[[
if data.raw.item["advanced-satellite"] then
	local amt = data.raw.technology["orbital-destroyer"].unit.ingredients[6][2]
	if amt > 1 then
		data.raw.technology["orbital-destroyer"].unit.ingredients[6][2] = amt*2
	end
end
--]]