Enemy = require "src.entity.enemy.Enemy"
ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

class BigEnemy extends Enemy
    @speed = 20
    @turnspeed = 10
    @refire_rate = 6
    @bullet = ExplodingBullet