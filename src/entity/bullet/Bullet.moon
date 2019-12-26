--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet
Vec2 = require "src.Vec2"

Bullet = (position = Vec2!, velocity = Vec2(0, 1)) ->
    {
        type: "Bullet"
        :position
        speed: 50
        velocity: velocity\normalize! * 50
        collision_radius: 10
    }

return Bullet