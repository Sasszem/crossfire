--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy


buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

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
        C.EnemyAI(120, 10, 60, 60, 30)



return BigEnemy
