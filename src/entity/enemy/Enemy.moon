Vec2 = require "src.Vec2"

class Enemy
    @speed = 30
    -- px/sec

    @turnspeed = 20
    -- degree/sec
    new: (pos = Vec2!) =>
        @position = pos
        @velocity = Vec2!
        @aim = 0
        @speed = @@speed
        @turnspeed = @@turnspeed
