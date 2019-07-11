Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

class BusterPlayer extends Player
    @speed = 100
    new: ( pos = Vec2!, aim = 0)=>
        super pos, aim
    