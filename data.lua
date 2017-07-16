require("prototypes.category")

require("prototypes.ammo")
require("prototypes.research")
require("prototypes.turrets")
require("prototypes.projectiles")
require("prototypes.radar")
require("prototypes.walls")
require("prototypes.tank")
require("prototypes.armor")

require("prototypes.recipes")

require("prototypes.item.cannon-turret-ammo")

require("prototypes.item.biter-flesh")

table.insert(data.raw['projectile']['explosive-cannon-projectile']['action']['action_delivery']['target_effects'], {type = "create-entity", entity_name = "small-scorchmark", check_buildability = true })

require("prototypes.entity.fire2")
require("prototypes.entity.radiationfire")

require("prototypes.item.flamethrower2")
require("prototypes.recipe.flamethrower2")
require("prototypes.technology.flamethrower2")
