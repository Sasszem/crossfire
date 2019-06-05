Vec2 = require "src.Vec2"

class OrbMovement
    update: (dt) =>
        for entity in *@pool.groups.orb.entities
            with entity
                .position += Vec2(math.random!-0.5, math.random!-0.5)*10*dt