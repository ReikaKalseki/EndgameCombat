require("prototypes.category")

require("prototypes.ammo")
require("prototypes.turrets")
require("prototypes.projectiles")
require("prototypes.radar")
require("prototypes.orbital")
require("prototypes.walls")
require("prototypes.dome")
require("prototypes.tank")

require("prototypes.research.equipment")
require("prototypes.armor")

require("prototypes.misc")

require("prototypes.item.cannon-turret-ammo")

require("prototypes.item.biter-flesh")

table.insert(data.raw['projectile']['explosive-cannon-projectile']['action']['action_delivery']['target_effects'], {type = "create-entity", entity_name = "small-scorchmark", check_buildability = true })

require("prototypes.entity.fire2")
require("prototypes.entity.radiationfire")

require("prototypes.item.flamethrower2")

require("prototypes.recipe.flamethrower2")
require("prototypes.recipe.ammo")
require("prototypes.recipe.turrets")
require("prototypes.recipe.defence")
require("prototypes.recipe.orbital")
require("prototypes.recipe.misc")

require("prototypes.research.flamethrower2")
require("prototypes.research.ammo")
require("prototypes.research.defense")
require("prototypes.research.turrets")
require("prototypes.research.upgrades")

require("turret-alerts")
