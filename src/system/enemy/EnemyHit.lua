local EnemyHit = {}

function EnemyHit:hit(entity)
    if self.pool.groups.enemy.hasEntity[entity] then
        if entity.despawnTimer ~= 0 then
            entity.despawnTimer = 0
            self.pool:emit("EnemyDeath", entity.position, entity.type)
        end
    end
end

return EnemyHit