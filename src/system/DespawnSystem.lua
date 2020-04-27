--- A system updating despawn timers and removing despawned entities
-- @classmod src.system.DespawnSystem

local DespawnSystem = {}

--- update event handler
-- @tparam number dt delta-time since prev. call
function DespawnSystem:update(dt)
    for _, entity in ipairs(self.pool.groups.despawn.entities) do
        if entity.despawnTimer > 0 then
            -- update timer
            entity.despawnTimer = entity.despawnTimer - dt
        end
    end

    self.pool:remove(self.removeFunc)
end

function DespawnSystem.removeFunc(entity)
    if entity.despawnTimer then
        if entity.despawnTimer <= 0 and entity.despawnTimer~=-1 then
            -- -1 is the special value of disabled despawn timer
            return true
        end
        return false
    end
end

return DespawnSystem