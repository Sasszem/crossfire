--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

Vec2 = require "src.Vec2"
class Player
    @speed = 50
    @collision_radius = 30

    new: ( pos = Vec2!, aim = 0)=>
        @position = pos
        @velocity = Vec2!
        @aim = aim
        @speed = @@speed
        @collision_radius = @@collision_radius
    