--- Handle 'hit' events with enemies
-- @classmod src.system.enemy.EnemyHit

class EnemyHit
    --- hit event handler
    -- @tparam Entity entity the entity hit
    hit: (entity) =>
        if @pool.groups.enemy.hasEntity[entity]
            if entity.despawnTimer != 0
                entity.despawnTimer = 0
                @pool\emit "EnemyDeath", entity.position, entity.type
