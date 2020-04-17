--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet

require "src.utils"

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Bullet = (position, angle=0, parent=nil) ->
    buildEntity "Bullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.DespawnComponent(15),
        C.BulletComponent!,
        {
            :parent
            draw: =>
                love.graphics.setColor(rgb(153, 0, 0))
                love.graphics.circle("fill", @position.x, @position.y, 10)
        }

return Bullet