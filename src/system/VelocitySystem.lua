--- A system for updating entity positions based on their velocities
-- @classmod src.system.VelocitySystem

local VelocitySystem = {}

--- update event handler
-- @tparam number dt delta-time since prev. call
function VelocitySystem:update(dt)
    for _, entity in ipairs(self.pool.groups.velocity.entities) do
        entity.position = entity.position + entity.velocity * dt
    end
end

return VelocitySystem