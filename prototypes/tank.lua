function make_heavy_gunshot_sounds(volume)
    return
    {
      {
        filename = "__base__/sound/fight/heavy-gunshot-1.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-2.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-3.ogg",
        volume = 0.45
      },
      {
        filename = "__base__/sound/fight/heavy-gunshot-4.ogg",
        volume = 0.45
      }
    }
end

local function rerouteSprite(e)
    -- if e is a table, we should iterate over its elements
    if type(e) == "table" then
        for k,v in pairs(e) do -- for every element in the table
            rerouteSprite(v)       -- recursively repeat the same procedure
			
			if e.filename then
				e.filename = string.gsub(e.filename, "__base__", "__EndgameCombat__")
			end
        end
    end
end

local tank = table.deepcopy(data.raw.car.tank)
tank.name = "better-tank"
tank.icon = "__EndgameCombat__/graphics/icons/tank.png"
tank.icon_size = 32
tank.minable = {mining_time = 3, result = "better-tank"}
tank.max_health = 4000
tank.dying_explosion = "massive-explosion"
tank.energy_per_hit_point = 0.5
tank.resistances =
    {
      {
        type = "fire",
        decrease = 20,
        percent = 75
      },
      {
        type = "physical",
        decrease = 80,
        percent = 90
      },
      {
        type = "impact",
        decrease = 80,
        percent = 100
      },
      {
        type = "explosion",
        decrease = 30,
        percent = 50
      },
      {
        type = "acid",
        decrease = 50,
        percent = 75
      }
    }
tank.effectivity = 0.85 --was 0.75
tank.braking_power = "600kW" --was 450
tank.burner.effectivity = 0.95 --was 0.85
tank.burner.fuel_inventory_size = 4
tank.consumption = "1200kW" --was 900
tank.friction = 2e-3
tank.rotation_speed = 0.005
tank.weight = 40000
tank.inventory_size = 80
tank.guns = { "better-tank-cannon", "better-submachine-gun" }

--rerouteSprite(tank.animation)

data:extend(
{
  tank,
  
  {
    type = "item",
    name = "better-tank",
    icon = "__EndgameCombat__/graphics/icons/tank.png",
	icon_size = 32,
    flags = {"goes-to-quickbar"},
    subgroup = "transport",
    order = "b[personal-transport]-b[tank]",
    place_result = "better-tank",
    stack_size = 1
  },
  
    {
    type = "gun",
    name = "better-submachine-gun",
    icon = "__base__/graphics/icons/submachine-gun.png",
	icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "gun",
    order = "a[basic-clips]-b[submachine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 2,
      movement_slow_down_factor = 0.75,
	  damage_modifier = 2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.6},
        creation_distance = 0.6,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 0.6,
      range = 30,
      sound = make_heavy_gunshot_sounds(),
    },
    stack_size = 1
  },
  
    {
    type = "gun",
    name = "better-tank-cannon",
    icon = "__base__/graphics/icons/tank-cannon.png",
	icon_size = 32,
    flags = {"goes-to-main-inventory", "hidden"},
    subgroup = "gun",
    order = "z[tank]-a[cannon]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell",
      cooldown = 60,
      movement_slow_down_factor = 0,
      projectile_creation_distance = 0.6,
      range = 80,
      sound =
      {
        {
          filename = "__base__/sound/fight/tank-cannon.ogg",
          volume = 0.3
        }
      }
    },
    stack_size = 5
  },
}
)
