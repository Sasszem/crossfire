--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Bullet = (position, angle=0) ->
    buildEntity "Bullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 50),
        C.CollisionComponent(10),
        C.DespawnComponent(10),
        C.BulletComponent!

return Bullet