--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

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
        C.TargetComponent!



return Enemy