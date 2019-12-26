--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy

Enemy = require "src.entity.enemy.Enemy"
ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

BigEnemy = (pos) -> 
    with Enemy(pos)
        .type = "BigEnemy"
        .speed = 20
        .turnspeed = 10
        .refire_rate = 6
        .bullet = ExplodingBullet

return BigEnemy