--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

ExplodingBullet = (position, angle=0, parent=nil) ->
    buildEntity "ExplodingBullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 30),
        C.CollisionComponent(10),
        C.ExplosionComponent(50),
        C.DespawnComponent(10),
        C.BulletComponent!,
        {
            :parent
        }

return ExplodingBullet