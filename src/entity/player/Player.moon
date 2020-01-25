--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
VelocityComponent = require "src.component.VelocityComponent"
CollisionComponent = require "src.component.CollisionComponent"
DirectionComponent = require "src.component.DirectionComponent"

Player = (position, angle=0) ->
    buildEntity "Player",
        PositionComponent position,
        VelocityComponent!,
        CollisionComponent 30,
        DirectionComponent!,
        {
            state: "Normal"
        }


return Player