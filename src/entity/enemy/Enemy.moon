--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

Vec2 = require "src.Vec2"
require "src.utils"

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"


Bullet = require "src.entity.bullet.Bullet"

Enemy = (position, angle=math.random(0, 360)) ->
    buildEntity "Enemy",
        C.PositionComponent position,
        C.VelocityComponent(nil, 30),
        C.DirectionComponent angle,
        C.CollisionComponent 30,
        C.ShootComponent(Bullet, 5),
        C.DespawnComponent!,
        C.TargetComponent!,
        C.EnemyAI(200, 40, 120, 70, 2),
        {
            age: 0
            draw: =>
                primary_color = rgb(255, 204, 0)
                secondary_color = rgb(230, 180, 0)

                if @age<0.2
                    t = @age * 5
                    primary_color = rgb(255, 255-51*t, 255-255*t)

                if @despawnTimer != -1
                    t = @despawnTimer * 5
                    primary_color = rgb(255, 204*t, 0)

                love.graphics.setColor(primary_color)
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", @position.x, @position.y, 30)
                love.graphics.setColor(secondary_color)
                --love.graphics.setColor(rgb(204, 102, 0))
                love.graphics.circle("line", @position.x, @position.y, 30)
                
                fr = @position + Vec2.fromAngle(@angle, 30)
                to = @position + Vec2.fromAngle(@angle, 50)
                love.graphics.setLineWidth(10)
                love.graphics.line(fr.x, fr.y, to.x, to.y)
                
                fr = @position + Vec2.fromAngle(@angle, 29)
                to = @position + Vec2.fromAngle(@angle, 49)
                love.graphics.setLineWidth(8)
                love.graphics.setColor(primary_color)
                love.graphics.line(fr.x, fr.y, to.x, to.y)
            update: (dt) =>
                @age += dt
        }



return Enemy
