data:extend(
{
--[[
   {
    type = "item-group",
    name = "better-ammo",
    order = "aaa-a",
    inventory_order = "c-a",
    icon = "__EndgameCombat__/graphics/icons/ammo.png",
  },]]
    {
    type = "ammo-category",
    name = "plasma-turret"
  },
    {
    type = "ammo-category",
    name = "concussion-turret"
  },
    {
    type = "ammo-category",
    name = "cannon-turret"
  },
    {
    type = "ammo-category",
    name = "shockwave-turret"
  },
    {
    type = "ammo-category",
    name = "acid-stream"
  },
    {
    type = "ammo-category",
    name = "lightning-turret"
  },
    {
    type = "ammo-category",
    name = "sticky-stream"
  },
}
)

data:extend(
{
  {
    type = "damage-type",
    name = "cutting" --used by spiked walls
  },
  {
    type = "damage-type",
    name = "radiation" --used by neutron bomb, unstoppable
  },
  {
    type = "damage-type",
    name = "cavitation" --ie internal injuries, for certain ammo types
  },
  {
    type = "damage-type",
    name = "sticky" --a marker for sticky turrets
  },
  {
    type = "damage-type",
    name = "napalm" --bypasses fire resist
  },
}
)