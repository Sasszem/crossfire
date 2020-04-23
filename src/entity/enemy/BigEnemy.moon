--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy

require "src.utils"

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Vec2 = require "src.Vec2"

ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

BigEnemy = (position, angle=math.random(0, 360)) ->
    buildEntity "BigEnemy",
        C.PositionComponent position,
        C.VelocityComponent!,
        C.DirectionComponent angle,
        C.CollisionComponent 30,
        C.ShootComponent(ExplodingBullet, 7),
        C.DespawnComponent!,
        C.TargetComponent!,
        C.EnemyAI(250, 30, 90, 60, 10),
        {
            age: 0
            draw: () =>

                primary_color = rgb(255, 102, 0)
                secondary_color = rgb(210, 90, 0)

                if @age<0.2
                    t = @age * 5
                    primary_color = rgb(255, 255-153*t, 255-255*t)

                if @despawnTimer != -1
                    t = @despawnTimer * 5
                    primary_color = rgb(255, 102*t, 0)

                love.graphics.setColor(primary_color)
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", @position.x, @position.y, 30)
                --love.graphics.setColor(rgb(204, 0, 0))
                love.graphics.setColor(secondary_color)
                love.graphics.circle("line", @position.x, @position.y, 30)
                
                fr = @position + Vec2.fromAngle(@angle, 30)
                to = @position + Vec2.fromAngle(@angle, 50)
                love.graphics.setLineWidth(14)
                love.graphics.line(fr.x, fr.y, to.x, to.y)
                
                fr = @position + Vec2.fromAngle(@angle, 29)
                to = @position + Vec2.fromAngle(@angle, 49)
                love.graphics.setLineWidth(12)
                love.graphics.setColor(primary_color)
                love.graphics.line(fr.x, fr.y, to.x, to.y)
            update: (dt) =>
                @age += dt
        }



return BigEnemy
