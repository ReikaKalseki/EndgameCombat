require "constants"

local function laststand_turret_sheet()
return
{
  layers = 
  {
    {
      filename = "__EndgameCombat__/graphics/entity/last-stand-turret.png",
      priority = "medium",
      scale = 1.5,
      width = 75,
      height = 75,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      axially_symmetrical = false,
      run_mode = "forward",
	  shift = { 0, 0 },
    }
  }
}
end

local function cannon_turret_sheet(inputs)
return
{
  layers = 
  {
    {
      filename = "__EndgameCombat__/graphics/entity/cannon-turret-sheet.png",
      priority = "medium",
      scale = 0.75,
      width = 128,
      height = 128,
      direction_count = inputs.direction_count and inputs.direction_count or 64,
      frame_count = 1,
      line_length = inputs.line_length and inputs.line_length or 8,
      axially_symmetrical = false,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
    shift = { 0.35, -0.5 },
    }
  }
}
end

data:extend(
{
  {
    type = "item",
    name = "concussion-turret",
    icon = "__EndgameCombat__/graphics/icons/gun-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[concussion-turret-1-2]",
    place_result = "concussion-turret",
    stack_size = 50
  },
    {
    type = "item",
    name = "plasma-turret",
    icon = "__EndgameCombat__/graphics/icons/laser-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[laser-turret]-f[plasma-turret-1-2]",
    place_result = "plasma-turret",
    stack_size = 50
  },
    {
    type = "item",
    name = "cannon-turret",
    icon = "__EndgameCombat__/graphics/icons/cannon-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[cannon-turret-1-2]",
    place_result = "cannon-turret",
    stack_size = 50
  },
    {
    type = "item",
    name = "shockwave-turret",
    icon = "__EndgameCombat__/graphics/icons/shockwave-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[shockwave-turret-1-2]",
    place_result = "shockwave-turret",
    stack_size = 50
  },--[[
    {
    type = "item",
    name = "bomb-turret", --throws bombs, for AOE damage, but not great rate of fire?
    icon = "__EndgameCombat__/graphics/icons/shockwave-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[bomb-turret-1-2]",
    place_result = "bomb-turret",
    stack_size = 50
  },--]]
  {
    type = "item",
    name = "last-stand-turret",
    icon = "__EndgameCombat__/graphics/icons/last-stand-turret-2.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[last-stand-turret-1-2]",
    place_result = "last-stand-turret",
    stack_size = 10
  },
  {
    type = "item",
    name = "acid-turret",
    icon = "__EndgameCombat__/graphics/icons/acid-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[acid-turret-1-2]",
    place_result = "acid-turret",
    stack_size = 10
  },
  {
    type = "item",
    name = "lightning-turret",
    icon = "__EndgameCombat__/graphics/icons/lightning-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[lightning-turret-1-2]",
    place_result = "lightning-turret",
    stack_size = 10
  },
  {
    type = "item",
    name = "sticky-turret",
    icon = "__EndgameCombat__/graphics/icons/sticky-turret.png",
	icon_size = 32,
    flags = {},
    subgroup = "defensive-structure",
    order = "f[gun-turret]-f[sticky-turret-1-2]",
    place_result = "sticky-turret",
    stack_size = 10
  }
}
)


local acid = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
acid.icon = data.raw.item["acid-turret"].icon
acid.name = "acid-turret"
acid.minable.result = acid.name
acid.resistances[1].type = "acid"
acid.max_health = 1600
acid.attack_parameters.ammo_category = "acid-stream"
acid.attack_parameters.fluids = {{type = "sulfuric-acid", damage_modifier = 1}}
acid.attack_parameters.ammo_type.category = "acid-stream"
acid.attack_parameters.ammo_type.action.action_delivery.stream = "acid-stream"
acid.muzzle_animation = nil

local stream = table.deepcopy(data.raw.stream["flamethrower-fire-stream"])
stream.name = "acid-stream"
stream.action = {
      {
        type = "area",
        radius = 4,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "damage",
              damage = { amount = 8, type = "acid" },
              apply_damage_to_trees = false
            }
          }
        }
      }
}
stream.spine_animation.filename = "__EndgameCombat__/graphics/entity/acid-turret/stream.png"
stream.particle.filename = "__EndgameCombat__/graphics/entity/acid-turret/puff.png"

local sticky = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
sticky.icon = data.raw.item["sticky-turret"].icon
sticky.name = "sticky-turret"
sticky.minable.result = sticky.name
sticky.max_health = 600
sticky.attack_parameters.ammo_category = "sticky-stream"
sticky.attack_parameters.fluids = {{type = "sticky", damage_modifier = 0}}
sticky.attack_parameters.ammo_type.category = "sticky-stream"
sticky.attack_parameters.ammo_type.action.action_delivery.stream = "sticky-stream"
sticky.muzzle_animation = nil
sticky.muzzle_light = nil
sticky.attack_parameters.min_range = 10
sticky.attack_parameters.range = 24 --from 30

local stream2 = table.deepcopy(data.raw.stream["flamethrower-fire-stream"])
stream2.name = "sticky-stream"
stream2.action = {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "sticky-patch"
            },
            {
              type = "create-entity",
              entity_name = "sticky-patch-render"
            }
          }
        }
      },
      {
        type = "area",
        radius = 2,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
				type = "create-sticker",
				sticker = "slowdown-sticker"
            }
          }
        }
      }
}
stream2.spine_animation.filename = "__EndgameCombat__/graphics/entity/sticky-turret/stream.png"
stream2.particle.filename = "__EndgameCombat__/graphics/entity/sticky-turret/puff.png"

local function create_sticky_picture(i)
	return
	    {
      filename = "__EndgameCombat__/graphics/entity/sticky-turret/splash-" .. i .. ".png",
      line_length = 1,
      width = 140,
      height = 95,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 0.5,
	  blend_mode = "normal",
      scale = 1.5,
	  priority = "very-low",
      flags = { "compressed" },
      --shift = { -0.0390625, -0.90625 }
    }
end
	  
local function create_sticky_pictures()
  local retval =
  {
	create_sticky_picture(1),
	create_sticky_picture(2),
	create_sticky_picture(3),
	create_sticky_picture(4),
  }
  return retval
end

local function createEmptyGraphic()
return {{
      filename = "__core__/graphics/empty.png",
      line_length = 1,
      width = 1,
      height = 1,
      frame_count = 1,
}}
end

local patch = table.deepcopy(data.raw.fire["fire-flame"])
patch.name = "sticky-patch"
patch.damage_per_tick = {amount = 0.000001, type = "sticky"} --have an event handler for this and apply the slowdown
patch.spawn_entity = "sticky-on-tree"
patch.on_fuel_added_action = nil
patch.add_fuel_cooldown = 99999
patch.smoke = nil
patch.light = nil
patch.working_sound = nil
patch.final_render_layer = "decals"
--patch.initial_lifetime = 
patch.burnt_patch_lifetime = 0
patch.duration = 900 --15s
patch.fade_in_duration = 1--15
patch.fade_out_duration = 1--15
patch.smoke_source_pictures = nil
patch.pictures = createEmptyGraphic()

local tree = table.deepcopy(data.raw.fire["fire-flame-on-tree"])
tree.name = "sticky-on-tree"
tree.damage_per_tick = {amount = 0.000001, type = "sticky"}
tree.tree_dying_factor = 0
tree.maximum_spread_count = 0
tree.spread_delay = 99999
tree.trivial_smoke = nil
tree.light = nil
tree.working_sound = nil
tree.smoke_source_pictures = nil
tree.pictures = createEmptyGraphic()

local patchimg = {
	type = "corpse",
	name = "sticky-patch-render",
	flags = {"not-on-map"},
	time_before_removed = patch.duration,
	final_render_layer = "corpse",--"decals",
	pictures = create_sticky_pictures(),
	splash = create_sticky_pictures()
}

data:extend(
{
acid, stream, sticky, stream2, patch, patchimg, tree,
{
    type = "ammo-turret",
    name = "concussion-turret",
    icon = "__EndgameCombat__/graphics/icons/gun-turret.png",
	icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "concussion-turret"},
    max_health = 2000,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.015,
    preparing_speed = 0.08,
    folding_speed = 0.08,
	fast_replaceable_group =  "gun-turret",
    dying_explosion = "medium-explosion",
    inventory_size = 2,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    call_for_help_radius = 50,
    resistances =
    {
      {
        type = "physical",
        decrease = 0,
        percent = 10
      },
      {
        type = "acid",
        decrease = 0,
        percent = 10
      },
    },
    folded_animation = 
    {
      layers =
      {
        gun_turret_extension{frame_count=1, line_length = 1},
        gun_turret_extension_mask{frame_count=1, line_length = 1},
        gun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation = 
    {
      layers =
      {
        gun_turret_extension{},
        gun_turret_extension_mask{},
        gun_turret_extension_shadow{}
      }
    },
    prepared_animation = gun_turret_attack{frame_count=1},
    attacking_animation = gun_turret_attack{},
    folding_animation = 
    { 
      layers = 
      { 
        gun_turret_extension{run_mode = "backward"},
        gun_turret_extension_mask{run_mode = "backward"},
        gun_turret_extension_shadow{run_mode = "backward"}
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/gun-turret/gun-turret-base.png",
          priority = "high",
          width = 90,
          height = 75,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
          shift = {0.0625, -0.046875},
        },
        {
          filename = "__EndgameCombat__/graphics/entity/gun-turret/gun-turret-base-mask.png",
          line_length = 1,
          width = 52,
          height = 47,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = {0.0625, -0.234375},
          apply_runtime_tint = true
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 6,
      projectile_creation_distance = 1.39375,
      projectile_center = {0.0625, -0.0875}, -- same as gun_turret_attack shift
      damage_modifier = 2,--5, --this value is a multiplier against the ammo; gun turrets have 1x --more DPS than plasma turret, but physical (and thus resisted against), so balanced
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = 22,
      sound = make_heavy_gunshot_sounds(),
    }
  },
  {
    type = "electric-turret",
    name = "plasma-turret",
    icon = "__EndgameCombat__/graphics/icons/laser-turret.png",
	icon_size = 32,
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    minable = { mining_time = 0.5, result = "plasma-turret" },
    max_health = 2000,
    corpse = "medium-remnants",
    collision_box = {{ -0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{ -1, -1}, {1, 1}},
    rotation_speed = 0.01,
    preparing_speed = 0.05,
	fast_replaceable_group =  "laser-turret",
    dying_explosion = "medium-explosion",
    folding_speed = 0.05,
    call_for_help_radius = 60,
    resistances =
    {
      {
        type = "physical",
        decrease = 0,
        percent = 10
      },
      {
        type = "acid",
        decrease = 0,
        percent = 10
      },
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "1.6MJ",
      input_flow_limit = "9.6MW",
      drain = "80kW",
      usage_priority = "primary-input"
    },
    folded_animation =
    {
      layers =
      {
        laser_turret_extension{frame_count=1, line_length = 1},
        laser_turret_extension_shadow{frame_count=1, line_length=1},
        laser_turret_extension_mask{frame_count=1, line_length=1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        laser_turret_extension{},
        laser_turret_extension_shadow{},
        laser_turret_extension_mask{}
      }
    },
    prepared_animation =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun.png",
          line_length = 8,
          width = 68,
          height = 68,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = {0.0625, -1}
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun-mask.png",
          line_length = 8,
          width = 54,
          height = 44,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 64,
          shift = {0.0625, -1.3125},
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-gun-shadow.png",
          line_length = 8,
          width = 88,
          height = 52,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          draw_as_shadow = true,
          shift = {1.59375, 0}
        }
      }
    },
    folding_animation = 
    {
      layers =
      {
        laser_turret_extension{run_mode = "backward"},
        laser_turret_extension_shadow{run_mode = "backward"},
        laser_turret_extension_mask{run_mode = "backward"}
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-base.png",
          priority = "high",
          width = 98,
          height = 82,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
          shift = { 0.109375, 0.03125 }
        },
        {
          filename = "__EndgameCombat__/graphics/entity/laser-turret/laser-turret-base-mask.png",
          line_length = 1,
          width = 54,
          height = 46,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 1,
          shift = {0.046875, -0.109375},
        },
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 12,
      projectile_center = {0, -0.2},
      projectile_creation_distance = 1.4,
      range = 30,
      damage_modifier = 5,
      ammo_type =
      {
        type = "projectile",
        category = "plasma-turret",
        energy_consumption = "600kJ",
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
              {
                type = "projectile",
                projectile = "plasma-laser",
                starting_speed = 0.28
              }
            }
          }
        }
      },
      sound = { filename = "__EndgameCombat__/sounds/plasmashot.ogg", volume = 0.75 },
    }
  },
  
  {
    type = "ammo-turret",
    name = "cannon-turret",
    icon = "__EndgameCombat__/graphics/icons/cannon-turret.png",
	icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "cannon-turret"},
    max_health = 1500,
    corpse = "medium-remnants",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    rotation_speed = 0.003,
    preparing_speed = 0.04,
    folding_speed = 0.04,
    dying_explosion = "medium-explosion",
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    
    folded_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    preparing_animation = cannon_turret_sheet{direction_count = 8, line_length = 1},
    prepared_animation = cannon_turret_sheet{},
    attacking_animation = cannon_turret_sheet{},
    folding_animation = cannon_turret_sheet{direction_count = 8, line_length = 1, run_mode = "backward"},
    
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell-magazine",
      cooldown = 180,
      projectile_creation_distance = 1.75,
      projectile_center = {0, 0},
      damage_modifier = 1,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = CANNON_TURRET_RANGE,
      min_range = CANNON_TURRET_INNER_RANGE,
      sound =
      {
        {
            filename = "__EndgameCombat__/sounds/cannon-turret.ogg",
            volume = 1.0
        }
      },
    },
    call_for_help_radius = 46
  },
  
    {
    type = "ammo-turret",
    name = "last-stand-turret",
    icon = "__EndgameCombat__/graphics/icons/last-stand-turret-2.png",
	icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "last-stand-turret"},
    max_health = 200,
    corpse = "big-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    rotation_speed = 0.1,
    preparing_speed = 0.1,
    folding_speed = 0.1,
    dying_explosion = "massive-explosion",
    inventory_size = 0,
    automated_ammo_count = 0,
    attacking_speed = 0.1,
    
    folded_animation = laststand_turret_sheet(),
    preparing_animation = laststand_turret_sheet(),
    prepared_animation = laststand_turret_sheet(),
    attacking_animation = laststand_turret_sheet(),
    folding_animation = laststand_turret_sheet(),
    
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 1,
      projectile_creation_distance = 1.75,
      projectile_center = {0, 0},
      damage_modifier = 1,
      shell_particle = nil,
      range = 1,
      sound = nil,
    },
    call_for_help_radius = 5
  },
}
)

local function createEmptyAnimation()
	local ret = {
		filename = "__EndgameCombat__/graphics/entity/shockwave-turret-trans.png",
        line_length = 1,
		width = 258,
		height = 186,
        frame_count = 1,
        axially_symmetrical = false,
        direction_count = 1,
        draw_as_shadow = false,
        --shift = {1.5, 0}
	}
	return ret
end

data:extend(
{
  {
    type = "electric-turret",
    name = "shockwave-turret",
    render_layer = "object",
    icon = "__EndgameCombat__/graphics/icons/shockwave-turret.png",
	icon_size = 32,
    flags = {"placeable-player", "placeable-neutral", "player-creation"},
    order = "s-e-w-f",
    minable = {mining_time = 1, result = "shockwave-turret"},
    max_health = 1500,
    corpse = "big-remnants",
	dying_explosion = "medium-explosion",
    collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
	folding_animation = createEmptyAnimation(),
	folded_animation = createEmptyAnimation(),
	prepared_animation = createEmptyAnimation(),
	preparing_animation = createEmptyAnimation(),
    base_picture =
    {
      filename = "__EndgameCombat__/graphics/entity/shockwave.png",
      priority = "extra-high",
      width = 258,
      height = 186,
	  scale = 0.5,
      shift = {0.6, 0},
      frame_count = 1,
    },
	call_for_help_radius = SHOCKWAVE_TURRET_RADIUS,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "1MJ",
      input_flow_limit = "2400kW",
      drain = "10kW",
      usage_priority = "primary-input"
    },
	attack_parameters =
    {
      type = "projectile",
      ammo_category = "electric",
      cooldown = 20,
      projectile_center = {-0.09375, -0.2},
      projectile_creation_distance = 1.4,
      range = SHOCKWAVE_TURRET_RADIUS,
      damage_modifier = 0,
      ammo_type =
      {
        type = "projectile",
        category = "shockwave-turret",
        energy_consumption = "0kJ",
        action =
        {
          {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
				projectile = "shockwave-dummy-projectile",
                starting_speed = 100
            }
          }
        }
      },
      sound = nil
    },
  },
})

data:extend({
  {
    type = "explosion",
    name = "shockwave-turret-effect",
	icon_size = 32,
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__EndgameCombat__/graphics/entity/shockwave-effect.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 197,
        height = 245,
        frame_count = 47,
        line_length = 6,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {0.1875, -0.75},
		scale = 1.0,
        animation_speed = 1,--0.5,
		blend_mode = "additive",
      }
    },
    light = {intensity = 1, size = 50, color = {r=0.72, g=1.0, b=1.0}},
    sound =
    {
      aggregation =
      {
        max_count = 1,
        remove = true
      },
      variations =
      {
        {
          filename = "__EndgameCombat__/sounds/shockwave-turret.ogg",
          volume = 0.8
        },
      }
    },
    created_effect = nil,--[[
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 20,
            entity_name = "explosion-remnants-particle",
            initial_height = 0.5,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.15,
            initial_vertical_speed = 0.08,
            initial_vertical_speed_deviation = 0.15,
            offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
          }
        }
      }
    }--]]
  },
  {
      type = "explosion",
      name = "shockwave-beam",
	  icon_size = 32,
      flags = {"not-on-map", "placeable-off-grid"},
      animation_speed = 1,
      rotate = true,
      beam = true,
      animations =
      {
        {
        filename = "__EndgameCombat__/graphics/entity/shockwave-beam.png",
        priority = "extra-high",
        width = 10,
        height = 180,
        frame_count = 6,
		blend_mode = "additive",
        }
      },
      light = {intensity = 0.1, size = 2},
      smoke = "smoke-fast",
      smoke_count = 1,
      smoke_slow_down_factor = 1
    },
		{
			type = "sound",
			name = "shockwave-sound",
			filename = "__EndgameCombat__/sounds/shockwave-turret.ogg",
			volume = 0.8
		},
	  {
    type = "projectile",
    name = "shockwave-dummy-projectile",
	icon_size = 32,
    flags = {"not-on-map"},
    acceleration = 0,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = { amount = 0, type = "laser"}
          }
        }
      }
    },
    light = nil,--{intensity = 0.5, size = 10},
    animation =
    {
      filename = "__EndgameCombat__/graphics/entity/dummy-projectile.png",
      tint = {r=1.0, g=1.0, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    },
    speed = 0
  }
})

function lightning_turret_extension()
return
{
  filename = "__EndgameCombat__/graphics/entity/lightning-turret/rotation.png",
  priority = "medium",
  width = 256,
  height = 256,
  frame_count = 1,
  line_length = 1,
  run_mode = "forward",
  axially_symmetrical = false,
  direction_count = 8,
  shift = {0.35, -1.4},
		  scale = 3/4,
}
end

function lightning_turret_extension_shadow()
return
{
  filename = "__EndgameCombat__/graphics/entity/lightning-turret/shadow.png",
  width = 256,
  height = 256,
  frame_count = 1,
  line_length = 1,
  run_mode = "forward",
  axially_symmetrical = false,
  direction_count = 8,
  draw_as_shadow = true,
  shift = {0.35, -1.4},
		  scale = 3/4,
}
end

data:extend({
{
    type = "electric-turret",
    name = "lightning-turret",
    icon = "__EndgameCombat__/graphics/icons/lightning-turret.png",
	icon_size = 32,
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    minable = { mining_time = 0.5, result = "lightning-turret" },
    max_health = 400, --glass cannon
    corpse = "medium-remnants",
    collision_box = {{ -1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    rotation_speed = 0.01,
    preparing_speed = 0.05,
	fast_replaceable_group = nil,
    dying_explosion = "medium-explosion",
    folding_speed = 0.05,
    call_for_help_radius = LIGHTNING_TURRET_RANGE,
    resistances = --glass cannon
    {

    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "7.2MJ", --6MJ to fire
      input_flow_limit = "12MW",
      drain = "300kW",
      usage_priority = "primary-input"
    },
    folded_animation =
    {
      layers =
      {
        lightning_turret_extension(),
        lightning_turret_extension_shadow(),
      }
    },
    preparing_animation =
    {
      layers =
      {
        lightning_turret_extension(),
        lightning_turret_extension_shadow(),
      }
    },
    prepared_animation =
    {
      layers =
      {
        {
          filename = "__EndgameCombat__/graphics/entity/lightning-turret/rotation.png",
          line_length = 8,
          width = 256,
          height = 256,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
		  scale = 3/4,
			shift = {0.35, -1.4},
        },
		--[[
        {
          filename = "__EndgameCombat__/graphics/entity/lightning-turret/lightning-turret-gun-mask.png",
          line_length = 8,
          width = 54,
          height = 44,
          frame_count = 1,
          axially_symmetrical = false,
          apply_runtime_tint = true,
          direction_count = 64,
          shift = {0.0625, -1.3125},
        },
		--]]
        {
          filename = "__EndgameCombat__/graphics/entity/lightning-turret/shadow.png",
          line_length = 8,
          width = 256,
          height = 256,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 64,
          draw_as_shadow = true,
		  scale = 3/4,
			shift = {0.35, -1.4},
        }
      }
    },
    folding_animation =
    {
      layers =
      {
        lightning_turret_extension(),
        lightning_turret_extension_shadow(),
      }
    },
    base_picture =
    {
      layers =
      {
        {
          filename = "__core__/graphics/empty.png",
          priority = "high",
          width = 1,
          height = 1,
          axially_symmetrical = false,
          frame_count = 1,
          direction_count = 1,
        },
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "lightning-turret",
      cooldown = LIGHTNING_TURRET_RECHARGE_TIME,
      range = LIGHTNING_TURRET_RANGE,
      damage_modifier = 1,
		ammo_type = {
			category = "lightning-turret",
			energy_consumption = LIGHTNING_TURRET_DISCHARGE_ENERGY .. "J",
			action = {
				type = "direct",
				action_delivery = {
					type = "beam",
					beam = "lightning-beam",
					max_length = LIGHTNING_TURRET_RANGE,
					duration = 20,
				}
			}
		},
      sound = {
      aggregation =
      {
        max_count = 25,
        remove = true
      }, variations = {
		{ filename = "__EndgameCombat__/sounds/lightning/fire1.ogg", volume = 2 },
		{ filename = "__EndgameCombat__/sounds/lightning/fire2.ogg", volume = 2 },
		{ filename = "__EndgameCombat__/sounds/lightning/fire3.ogg", volume = 2 },
		{ filename = "__EndgameCombat__/sounds/lightning/fire4.ogg", volume = 2 },
	  }},
    }
  },
  {
    type = "explosion",
    name = "lightning-charge-sound",
	icon_size = 32,
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 1,
        height = 1,
		frame_count = 1
      }
    },
    light = nil,
    sound =
    {
      aggregation =
      {
        max_count = 5,
        remove = true
      },
      variations =
      {
        {
          filename = "__EndgameCombat__/sounds/lightning/charge.ogg",
          volume = 0.75
        },
      }
    },
    created_effect = nil,
  },
  {
    type = "explosion",
    name = "lightning-discharge-sound",
	icon_size = 32,
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        flags = { "compressed" },
        width = 1,
        height = 1,
		frame_count = 1
      }
    },
    light = nil,
    sound =
    {
      aggregation =
      {
        max_count = 5,
        remove = true
      },
      variations =
      {
        {
          filename = "__EndgameCombat__/sounds/lightning/discharge.ogg",
          volume = 2
        },
      }
    },
    created_effect = nil,
  },
  {
      type = "explosion",
      name = "lightning-beam-fx",
	  icon_size = 32,
      flags = {"not-on-map", "placeable-off-grid"},
      animation_speed = 0.5,
      rotate = true,
      beam = true,
      animations =
      {
        {
        filename = "__EndgameCombat__/graphics/entity/lightning-turret/lightning-beam-3-capped.png",
        priority = "extra-high",
        width = 24,
        height = 256,
        frame_count = 16,
		animation_speed = 0.5,
		scale = 1.6,
		blend_mode = "additive",
        }
      },
      light = {intensity = 0.8, size = 8},
      smoke = "smoke-fast",
      smoke_count = 1,
      smoke_slow_down_factor = 1
    },
})