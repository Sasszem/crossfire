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
                t = 0
                if @despawnTimer <= 1
                    t = 1 - @despawnTimer
                love.graphics.setColor(rgb(153+t*102, 255*t, 255*t, 255-255*t))
                love.graphics.circle("fill", @position.x, @position.y, 10-5*t)        

            update: (dt) =>
                if @wallCollision
                    @despawnTimer = math.min(1, @despawnTimer)
                if @despawnTimer <= 1
                    @collision_radius = 0
        }

return Bullet