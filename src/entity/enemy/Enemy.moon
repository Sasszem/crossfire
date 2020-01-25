--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

buildEntity = require "src.entity.buildEntity"
PositionComponent = require "src.component.PositionComponent"
VelocityComponent = require "src.component.VelocityComponent"
CollisionComponent = require "src.component.CollisionComponent"
DirectionComponent = require "src.component.DirectionComponent"
ShootComponent = require "src.component.ShootComponent"

Bullet = require "src.entity.bullet.Bullet"

Enemy = (position, angle=0) ->
    buildEntity "Enemy",
        PositionComponent position,
        VelocityComponent(nil, 30),
        DirectionComponent angle,
        CollisionComponent 30,
        ShootComponent(Bullet, 3)



return Enemy