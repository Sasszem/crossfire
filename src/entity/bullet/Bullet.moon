--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet
Vec2 = require "src.Vec2"

class Bullet
    @speed = 50
    @collision_radius = 10
    new: (position = Vec2!, velocity = Vec2 0, 1)=>
        @position = position
        @velocity = velocity\normalize! * @@speed
        @collision_radius = @@collision_radius