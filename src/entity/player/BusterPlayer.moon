Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

class BusterPlayer extends Player
    new: ( pos = Vec2!, aim = 0)=>
        super pos, aim
        @speed = @speed*2
    