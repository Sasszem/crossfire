--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

Vec2 = require "src.Vec2"
Bullet = require "src.entity.bullet.Bullet"

Enemy = (pos = Vec2!) ->
    {
        type: "Enemy"
        position: pos
        velocity: Vec2!
        aim: 0
        speed: 30
        turnspeed: 20
        refire_rate: 3
        shoot_cooldown: 3
        bullet: Bullet
    }

return Enemy