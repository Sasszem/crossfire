Vec2 = require "src.Vec2"

class Bullet
    @speed = 50

    new: (position = Vec2!, velocity = Vec2 0, 1)=>
        @position = position
        @velocity = velocity\normalize! * @@speed