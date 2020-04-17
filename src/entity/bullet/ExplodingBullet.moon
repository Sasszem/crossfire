--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

require "src.utils"

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
            draw: =>
                love.graphics.setColor(rgb(0, 153, 255, 128))
                love.graphics.circle("fill", @position.x, @position.y, 14)
                love.graphics.setColor(rgb(0, 0, 255))
                love.graphics.circle("fill", @position.x, @position.y, 10)
        }

return ExplodingBullet