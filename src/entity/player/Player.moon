Vec2 = require "src.Vec2"

class Player
    new: ( pos = Vec2!, aim = 0)=>
        @position = pos
        @velocity = Vec2!
        @aim = aim
        @speed = 50
    