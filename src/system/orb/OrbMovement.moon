--- Wiggle all the @{src.entity.orb.Orb}s randomly
-- @classmod src.system.orb.OrbMovement
Vec2 = require "src.Vec2"

class OrbMovement
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.orb.entities
            with entity
                .position += Vec2(math.random!-0.5, math.random!-0.5)*10*dt