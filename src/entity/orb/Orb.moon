Vec2 = require "src.Vec2"

class Orb
    new: ( pos = Vec2! )=>
        @position = pos
        @velocity = Vec2!