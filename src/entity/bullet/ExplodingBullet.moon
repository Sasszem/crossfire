--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet
Bullet = require "src.entity.bullet.Bullet"

class ExplodingBullet extends Bullet
    @@speed = 30