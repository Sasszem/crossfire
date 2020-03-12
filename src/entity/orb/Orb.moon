--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"


Orb = (position) ->
    buildEntity "Orb",
        C.PositionComponent(position),
        C.DespawnComponent(15)

return Orb