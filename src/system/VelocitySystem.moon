--- A system for updating entity positions based on their velocities
-- @classmod src.system.VelocitySystem
class VelocitySystem

    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.velocity.entities
            with entity
                .position += .velocity * dt        