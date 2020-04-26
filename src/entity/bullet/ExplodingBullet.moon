--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

require "src.utils"

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

ExplodingBullet = (position, angle=0, parent=nil) ->
    buildEntity "ExplodingBullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.ExplosionComponent(50),
        C.DespawnComponent(10),
        C.BulletComponent!,
        {
            drawLayer: 1
            :parent
            draw: =>
                t = 0
                if @despawnTimer < 1
                    t = 1-@despawnTimer
                love.graphics.setColor(rgb(0, 153, 255, 128-t*128))
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", @position.x, @position.y, 14)
                love.graphics.circle("line", @position.x, @position.y, 14)
                love.graphics.setColor(rgb(0, 0, 255, 255-t*255))
                love.graphics.circle("fill", @position.x, @position.y, 10)
                love.graphics.circle("line", @position.x, @position.y, 10)
            update: (dt) =>
                if @despawnTimer <= 1
                    @collision_radius = 0
        }

return ExplodingBullet