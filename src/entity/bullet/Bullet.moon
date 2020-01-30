--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet

buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
VelocityComponent = require "src.component.VelocityComponent"
CollisionComponent = require "src.component.CollisionComponent"
DespawnComponent = require "src.component.DespawnComponent"

Bullet = (position, angle=0) ->
    buildEntity "Bullet",
        PositionComponent(position),
        VelocityComponent.fromPolar(angle, 50),
        CollisionComponent(10),
        DespawnComponent(10)

return Bullet