Config = {}

Config.spacePlasma = settings.startup["space-plasma"].value--false

Config.spaceNukes = settings.startup["space-nukes"].value--false

Config.deconstructFlesh = settings.startup["deconstruct-flesh"].value--true

Config.bitersDropFlesh = settings.startup["flesh-unit-drops"].value--true

Config.deconstructFleshTimer = settings.startup["deconstruct-flesh-timer"].value--10

Config.radiationTimer = settings.startup["radiation-timer"].value--15

Config.cratedAmmoBoost = settings.startup["crated-ammo-boost"].value--10

Config.rottingFlesh = settings.startup["rotting-flesh"].value--true

Config.superBiters = settings.startup["super-biters"].value--true

Config.lowAmmoThreshold = settings.global and settings.global["low-ammo-warning"].value or 0

Config.continueAlarms = settings.startup["continue-alarms"].value

Config.dynamicAlarms = settings.startup["smarter-alarms"].value

Config.napalmTrees = settings.startup["napalm-trees"].value

Config.plasticShockwave = settings.startup["plastic-shockwave"].value

Config.error = function(msg)
	msg = msg .. " [This error can be silenced in the EndgameCombat config.lua]"
	log(msg) --change 'error' to 'log' (or remove this line entirely) to have the game not halt. DO NOTE THAT THIS RISKS CRASHES LATER ON!
end