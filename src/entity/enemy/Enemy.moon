--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

Vec2 = require "src.Vec2"
require "src.utils"

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"


Bullet = require "src.entity.bullet.Bullet"

Enemy = (position, angle=0) ->
    buildEntity "Enemy",
        C.PositionComponent position,
        C.VelocityComponent(nil, 30),
        C.DirectionComponent angle,
        C.CollisionComponent 30,
        C.ShootComponent(Bullet, 3),
        C.DespawnComponent!,
        C.TargetComponent!,
        C.EnemyAI(200, 20, 90, 70, 20),
        {
            draw: =>
                love.graphics.setColor(rgb(255, 204, 0))
                love.graphics.circle("fill", @position.x, @position.y, 30)
                v = Vec2.fromAngle(@angle, 50)
                love.graphics.setLineWidth(10)
                love.graphics.line(@position.x, @position.y, @position.x + v.x, @position.y + v.y)
        }



return Enemy
