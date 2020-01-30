--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy


buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
VelocityComponent = require "src.component.VelocityComponent"
CollisionComponent = require "src.component.CollisionComponent"
DirectionComponent = require "src.component.DirectionComponent"
ShootComponent = require "src.component.ShootComponent"
DespawnComponent = require "src.component.DespawnComponent"

ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

BigEnemy = (position, angle=0) ->
    buildEntity "BigEnemy",
        PositionComponent position,
        VelocityComponent!,
        DirectionComponent angle,
        CollisionComponent 30,
        ShootComponent(ExplodingBullet, 6),
        DespawnComponent!



return BigEnemy