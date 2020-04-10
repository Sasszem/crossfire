--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy


buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Vec2 = require "src.Vec2"

ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

BigEnemy = (position, angle=0) ->
    buildEntity "BigEnemy",
        C.PositionComponent position,
        C.VelocityComponent!,
        C.DirectionComponent angle,
        C.CollisionComponent 30,
        C.ShootComponent(ExplodingBullet, 6),
        C.DespawnComponent!,
        C.TargetComponent!,
        C.EnemyAI(120, 10, 60, 60, 30),
        {
            draw: () =>
                love.graphics.setColor {255/255, 102/255, 0/255}
                love.graphics.circle "fill", @position.x, @position.y, 35
                v = Vec2.fromAngle @angle, 50
                love.graphics.setLineWidth 15
                love.graphics.line @position.x, @position.y, @position.x + v.x, @position.y + v.y
        }



return BigEnemy
