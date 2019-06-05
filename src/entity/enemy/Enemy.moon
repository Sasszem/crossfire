Vec2 = require "src.Vec2"

class Enemy
    @speed = 30
    new: (pos = Vec2!) =>
        @position = pos
        @velocity = Vec2!
        @aim = Vec2!
