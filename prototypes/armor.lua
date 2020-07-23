data:extend(
{
  {
    type = "equipment-grid",
    name = "huge-equipment-grid",
    width = 16,
    height = 24,
    equipment_categories = {"armor"}
  }
}
)

local function createCloudDumpEquipment(name, cname, ammo)
	log("Loading " .. name .. " with " .. (cname and (cname.acceleration and cname.name or cname) or "nil") .. " , " .. (ammo and ammo.name or "nil"))
	local tempshot = nil
	if cname.acceleration then --is already a projectile type
		tempshot = table.deepcopy(cname)
		cname = nil
	end
	local capsule = cname and data.raw.capsule[cname] or nil
	if not capsule then error("Capsule '" .. cname .. "' does not exist!") end
	local proj = capsule.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile
	local shot = tempshot and tempshot or (capsule and table.deepcopy(data.raw.projectile[proj]) or nil)
	if not shot then error("Capsule '" .. cname .. "' returned null shot ('" .. proj .. "')!") end
	local key = shot.action[1].action_delivery.target_effects[1].entity_name
	if not key then error("Capsule '" .. cname .. "' returned null cloud name (" .. serpent.block(shot.action) .. ") !") end
	local cloud = shot and table.deepcopy(data.raw["smoke-with-trigger"][key]) or nil
	if not cloud then error("Capsule '" .. cname .. "' returned null cloud lookup ('" .. key .. "') !") end
	if not cloud.action then error("Error creating cloud dump for capsule '" .. cname .. "': cloud '" .. cloud.name .. "' has no action!" .. serpent.block(cloud)) end
	shot.name = shot.name .. "-auto"
	cloud.name = cloud.name .. "-auto"
	shot.action[1].action_delivery.target_effects[1].entity_name = cloud.name
	cloud.duration = cloud.duration == 1 and 1 or math.max(10, math.floor(cloud.duration/10))
	cloud.fade_away_duration = cloud.fade_away_duration == 1 and 1 or math.max(4, math.floor(cloud.fade_away_duration/10))
	cloud.spread_duration = cloud.spread_duration == 1 and 1 or math.max(4, math.floor(cloud.spread_duration/10))
	cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount = cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount/3 --since spamming them
	data:extend({shot, cloud})
  
  local item = {
    type = "item",
    name = name,
    icons = {{icon=shot.icon and shot.icon or capsule.icon}, {icon="__EndgameCombat__/graphics/icons/capsule-launcher-equipment.png"}}, -- icon="__EndgameCombat__/graphics/icons/" .. name .. ".png",
	icon_size = 32,
    placed_as_equipment_result = name,
    flags = {},
    subgroup = "equipment",
    order = "d[active-defense]-a[" .. name .. "]",
    stack_size = 20
  }
  local proto =     {
    type = "active-defense-equipment",
    name = name,
    sprite =
    {
      filename = "__EndgameCombat__/graphics/equipment/capsule-launcher-equipment.png",--"__EndgameCombat__/graphics/equipment/" .. name .. ".png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 3,
      height = 3,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      buffer_capacity = "25kJ"
    },
    categories = {"armor"},
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 5,
      damage_modifier = 0,
      projectile_center = {0, 0},
      projectile_creation_distance = 0.0,
      range = 8,
      sound = nil,
      ammo_type =
      {
        type = "projectile",
        category = "electric",
        energy_consumption = "1kJ",
        projectile = shot.name,
        speed = 10,
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = shot.name,
                starting_speed = 10
              }
            }
          }
        }
      }
    },
    automatic = true
  }
  local recipe = {
    type = "recipe",
    name = name,
    enabled = false,
    energy_required = 20,
    ingredients = {
		{ammo and ammo.name or cname, 100},
		{"processing-unit", 25},
		{"pipe", 10},
	},
    result = name
  }
  
  data:extend({item, proto, recipe})
  
  table.insert(data.raw.technology["advanced-equipment"].effects, {type="unlock-recipe", recipe=name})
end
  
createCloudDumpEquipment("poison-cloud-equipment", "poison-capsule")
createCloudDumpEquipment("acid-spraying-equipment", "acid-capsule")
createCloudDumpEquipment("radiation-spraying-equipment", "radiation-capsule")

local firecap = createDerivedCapsule("fire", nil, nil, 1, {r=1,g=0,b=0}, true)
firecap.cloud.fade_away_duration = 0
firecap.cloud.fade_in_duration = 0
firecap.cloud.spread_duration = 0
registerObjectArray(firecap)

createCloudDumpEquipment("fire-spraying-equipment", firecap.item.name, data.raw.ammo["flamethrower-ammo"])

local plasmalaser = table.deepcopy(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"])
plasmalaser.name = "advanced-laser-defense-equipment"
plasmalaser.sprite = {filename = "__EndgameCombat__/graphics/equipment/advanced-laser-defense-equipment.png", width = 64, height = 96, priority = "medium"}
plasmalaser.shape = {width = 2, height = 3, type = "full"}
plasmalaser.energy_source.buffer_capacity = "750kJ"
plasmalaser.attack_parameters.damage_modifier = 8
plasmalaser.attack_parameters.cooldown = 20
plasmalaser.attack_parameters.range = 20
plasmalaser.attack_parameters.sound = { filename = "__EndgameCombat__/sounds/plasma/shot.ogg", volume = 0.75 }
plasmalaser.attack_parameters.ammo_type.category = "plasma-turret"
plasmalaser.attack_parameters.ammo_type.energy_consumption = "100kJ"
plasmalaser.attack_parameters.ammo_type.action.action_delivery = {type = "beam", beam = "plasma-beam", max_length = 20, duration = 12, source_offset = {0, -0.5}}

data:extend(
{
  {
    type = "armor",
    name = "power-armor-mk3",
    icon = "__EndgameCombat__/graphics/icons/power-armor-mk3.png",
	icon_size = 32,
    flags = {},
    resistances =
    {
      {
        type = "physical",
        decrease = 10,
        percent = 60
      },
      {
        type = "acid",
        decrease = 10,
        percent = 60
      },
      {
        type = "fire",
        percent = 80
      },
      {
        type = "explosion",
        decrease = 20,
        percent = 70
      },
      {
        type = "radiation",
        percent = 100
      },
      {
        type = "impact",
		decrease = 50,
        percent = 90
      }
    },
    --durability = 40000,
    subgroup = "armor",
    order = "e[power-armor-mk3]",
    stack_size = 1,
    infinite = true,
    equipment_grid = "huge-equipment-grid",
    inventory_size_bonus = 40
  },
  
  {
    type = "item",
    name = "advanced-laser-defense-equipment",
    icon = "__EndgameCombat__/graphics/icons/advanced-laser-defense-equipment.png",
	icon_size = 32,
    placed_as_equipment_result = "advanced-laser-defense-equipment",
    flags = {},
    subgroup = "equipment",
    order = "d[active-defense]-a[advanced-laser-defense-equipment]",
    stack_size = 20
  },  
plasmalaser,   
}
)