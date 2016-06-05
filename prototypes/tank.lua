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

data:extend(
{
  {
    type = "car",
    name = "better-tank",
    icon = "__EndgameCombat__/graphics/icons/tank.png",
    flags = {"pushable", "placeable-neutral", "player-creation"},
    minable = {mining_time = 3, result = "better-tank"},
    max_health = 4000,
    corpse = "medium-remnants",
    dying_explosion = "massive-explosion",
    energy_per_hit_point = 0.5,
    resistances =
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
    },
    collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
    selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
    effectivity = 0.85, --was 0.75
    braking_power = "600kW", --was 450
    burner =
    {
      effectivity = 0.95, --was 0.85
      fuel_inventory_size = 4,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.25, 0.25},
          frequency = 50,
          position = {0, 1.5},
          slow_down_factor = 0.9,
          starting_frame = 3,
          starting_frame_deviation = 5,
          starting_frame_speed = 0,
          starting_frame_speed_deviation = 5
        }
      }
    },
    consumption = "1200kW", --was 900
    friction = 2e-3,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "medium",
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14},
        size = 2,
        intensity = 0.6
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "medium",
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14},
        size = 2,
        intensity = 0.6
      }
    },
    animation =
    {
      layers =
      {
        {
          width = 139,
          height = 110,
          frame_count = 2,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {-0.140625, -0.28125},
          animation_speed = 8,
          max_advance = 1,
          stripes =
          {
            {
             filename = "__EndgameCombat__/graphics/entity/tank/base-1.png",
             width_in_frames = 2,
             height_in_frames = 16,
            },
            {
             filename = "__EndgameCombat__/graphics/entity/tank/base-2.png",
             width_in_frames = 2,
             height_in_frames = 16,
            },
            {
             filename = "__EndgameCombat__/graphics/entity/tank/base-3.png",
             width_in_frames = 2,
             height_in_frames = 16,
            },
            {
             filename = "__EndgameCombat__/graphics/entity/tank/base-4.png",
             width_in_frames = 2,
             height_in_frames = 16,
            }
          }
        },
        {
          width = 109,
          height = 88,
          frame_count = 2,
          apply_runtime_tint = true,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {-0.140625, -0.65625},
          max_advance = 1,
          line_length = 2,
          stripes = util.multiplystripes(2,
          {
            {
              filename = "__base__/graphics/entity/tank/base-mask-1.png",
              width_in_frames = 1,
              height_in_frames = 22,
            },
            {
              filename = "__base__/graphics/entity/tank/base-mask-2.png",
              width_in_frames = 1,
              height_in_frames = 22,
            },
            {
              filename = "__base__/graphics/entity/tank/base-mask-3.png",
              width_in_frames = 1,
              height_in_frames = 20,
            },
          })
        },
        {
          width = 154,
          height = 99,
          frame_count = 2,
          draw_as_shadow = true,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {0.59375, 0.328125},
          max_advance = 1,
          stripes = util.multiplystripes(2,
          {
           {
            filename = "__base__/graphics/entity/tank/base-shadow-1.png",
            width_in_frames = 1,
            height_in_frames = 16,
           },
           {
            filename = "__base__/graphics/entity/tank/base-shadow-2.png",
            width_in_frames = 1,
            height_in_frames = 16,
           },
           {
            filename = "__base__/graphics/entity/tank/base-shadow-3.png",
            width_in_frames = 1,
            height_in_frames = 16,
           },
           {
            filename = "__base__/graphics/entity/tank/base-shadow-4.png",
            width_in_frames = 1,
            height_in_frames = 16,
           }
          })
        }
      }
    },
    turret_animation =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/tank/turret.png",
          line_length = 8,
          width = 92,
          height = 69,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {-0.15625, -1.07812},
          animation_speed = 8,
        },
        {
          filename = "__base__/graphics/entity/tank/turret-mask.png",
          line_length = 8,
          width = 38,
          height = 29,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 64,
          shift = {-0.15625, -1.23438},
        },
        {
          filename = "__base__/graphics/entity/tank/turret-shadow.png",
          line_length = 8,
          width = 95,
          height = 67,
          frame_count = 1,
          axially_symmetrical = false,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {1.70312, 0.640625},
        }
      }
    },
    turret_rotation_speed = 0.35 / 60,
    stop_trigger_speed = 0.2,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.6
          },
        }
      },
    },
    crash_trigger = crash_trigger(),
    sound_minimum_speed = 0.15;
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.6
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.6
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.6
      },
      match_speed_to_activity = true,
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
    rotation_speed = 0.005,
    tank_driving = true,
    weight = 40000,
    inventory_size = 80,
    guns = { "better-tank-cannon", "better-submachine-gun" },
  },
  
  {
    type = "item",
    name = "better-tank",
    icon = "__EndgameCombat__/graphics/icons/tank.png",
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
