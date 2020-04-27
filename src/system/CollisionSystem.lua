
--- System for detecting collisions and dispatching collision events
-- @classmod src.system.CollisionSystem

local CollisionSystem = {}

--- update event handler
-- @tparam number dt delta-time since prev. call
function CollisionSystem:update(dt)
    for _, entity in ipairs(self.pool.groups.collision.entities) do
        for _, other in ipairs(self.pool.groups.collision.entities) do
            if other ~= entity and other.collisionRadius~=0 and entity.collisionRadius~=0 then
                local distance = (entity.position - other.position):length()
                if distance <= entity.collisionRadius + other.collisionRadius then
                    self.pool:emit("collision", entity, other)
                end
            end
        end
    end
end

return CollisionSystem