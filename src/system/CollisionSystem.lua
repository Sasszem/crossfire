
--- System for detecting collisions and dispatching collision events
-- @classmod src.system.CollisionSystem

local CollisionSystem = {}

--- update event handler
-- @tparam number dt delta-time since prev. call
function CollisionSystem:update(dt)
    for _, entity in ipairs(self.pool.groups.collision.entities) do
        for _, other in ipairs(self.pool.groups.collision.entities) do
            if other ~= entity and other.collision_radius~=0 and entity.collision_radius~=0 then
                local distance = (entity.position - other.position):length()
                if distance <= entity.collision_radius + other.collision_radius then
                    self.pool:emit("collision", entity, other)
                end
            end
        end
    end
end

return CollisionSystem        