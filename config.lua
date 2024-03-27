Config = {}

if not settings then return end

Config.spacePlasma = settings.startup["space-plasma"].value--[[@as boolean]]

Config.spaceNukes = settings.startup["space-nukes"].value--[[@as boolean]]

Config.deconstructFlesh = settings.startup["deconstruct-flesh"].value--[[@as boolean]]

Config.bitersDropFlesh = settings.startup["flesh-unit-drops"].value--[[@as boolean]]

Config.deconstructFleshTimer = settings.startup["deconstruct-flesh-timer"].value--[[@as number]]

Config.radiationTimer = settings.startup["radiation-timer"].value--[[@as number]]

Config.cratedAmmoBoost = settings.startup["crated-ammo-boost"].value--[[@as number]]

Config.rottingFlesh = settings.startup["rotting-flesh"].value--[[@as boolean]]

Config.superBiters = settings.startup["super-biters"].value--[[@as boolean]]
Config.superWorms = settings.startup["super-worms"].value--[[@as boolean]]

Config.lowAmmoThreshold = settings.global and settings.global["low-ammo-warning"].value or 0

Config.continueAlarms = settings.startup["continue-alarms"].value--[[@as boolean]]

Config.dynamicAlarms = settings.startup["smarter-alarms"].value--[[@as boolean]]

Config.napalmTrees = settings.startup["napalm-trees"].value--[[@as boolean]]

Config.plasticShockwave = settings.startup["plastic-shockwave"].value--[[@as boolean]]

Config.artilleryRange = settings.startup["artillery-range"].value--[[@as number]]

Config.satellitePerOrbitalRadar = settings.startup["orbital-radar-each"].value--[[@as boolean]]

Config.biterAlert = settings.startup["biter-nest-spawn-alert"].value--[[@as boolean]]

Config.alerts = {}

Config.alertSounds = {
	settings.startup["enable-alert-sound-immediate"].value,
	settings.startup["enable-alert-sound-critical"].value,
	settings.startup["enable-alert-sound-low"].value
}

--Config.orbitalLaunches = settings.startup["orbital-launches"].value

Config.error = function(msg)
	msg = msg .. " [This error can be silenced in the EndgameCombat config.lua]"
	log(msg) --change 'error' to 'log' (or remove this line entirely) to have the game not halt. DO NOTE THAT THIS RISKS CRASHES LATER ON!
end