--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

Vec2 = require "src.Vec2"

Player = (pos = Vec2!, aim = 0) ->
    {
        type: "Player"
        position: pos
        velocity: Vec2!
        :aim
        speed: 50
        collision_radius: 30
        state: "Normal"
    }

return Player