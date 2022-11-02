local flamethrower = table.deepcopy(data.raw.gun.flamethrower)
flamethrower.name = "flamethrower-2"
flamethrower.attack_parameters.range = 30

data:extend({
  flamethrower
})
