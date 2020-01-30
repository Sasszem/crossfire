--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
VelocityComponent = require "src.component.VelocityComponent"
CollisionComponent = require "src.component.CollisionComponent"
ExplosionComponent = require "src.component.ExplosionComponent"
DespawnComponent = require "src.component.DespawnComponent"


ExplodingBullet = (position, angle=0) ->
    buildEntity "ExplodingBullet",
        PositionComponent(position),
        VelocityComponent.fromPolar(angle, 30),
        CollisionComponent(10),
        ExplosionComponent(50),
        DespawnComponent(10)

return ExplodingBullet