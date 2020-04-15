--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"


Player = (position, angle=0) ->
    buildEntity "Player",
        C.PositionComponent position,
        C.VelocityComponent!,
        C.CollisionComponent 50,
        C.DirectionComponent!,
        C.DespawnComponent!,
        C.TargetComponent!,
        C.LivesCounterComponent!,
        {
            state: "Normal"
            powerupCancel: -1
        }


return Player
