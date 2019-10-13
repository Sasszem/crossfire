--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

Vec2 = require "src.Vec2"
Bullet = require "src.entity.bullet.Bullet"

class Enemy
    @speed = 30
    -- px/sec

    @turnspeed = 20
    -- degree/sec

    @refire_rate = 3
    @bullet = Bullet

    new: (pos = Vec2!) =>
        @position = pos
        @velocity = Vec2!
        @aim = 0
        @speed = @@speed
        @turnspeed = @@turnspeed
        
        @refire_rate = @@refire_rate
        @shoot_cooldown = @refire_rate
        @bullet = @@bullet
