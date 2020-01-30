--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
DespawnComponent = require "src.component.DespawnComponent"

Orb = (position) ->
    buildEntity "Orb",
        PositionComponent(position),
        DespawnComponent(15)

return Orb