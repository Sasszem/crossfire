local EnemyHit = {}

function EnemyHit:hit(entity)
    if self.pool.groups.enemy.hasEntity[entity] then
        if entity.despawnTimer == -1 then
            entity.despawnTimer = 0.2
            if entity.tween then
                entity.tween:stop()
            end
            self.pool:emit("EnemyDeath", entity.position, entity.type)
        end
    end
end

return EnemyHit