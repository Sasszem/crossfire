--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet
Bullet = require "src.entity.bullet.Bullet"
Vec2 = require "src.Vec2"

ExplodingBullet = (position = Vec2!, velocity = Vec2(0, 1)) ->
    with Bullet(position, velocity)
        .type = "ExplodingBullet"
        .speed = 30
        .explosionRadius = 50
        .velocity = .velocity\normalize! * 30
return ExplodingBullet