--- Handle 'hit' events with enemies
-- @classmod src.system.enemy.EnemyHit

class EnemyHit
    --- hit event handler
    -- @tparam Entity entity the entity hit
    hit: (entity) =>
        if @pool.groups.enemy.hasEntity[entity]
            entity.despawnTimer = 0
            @pool\emit "EnemyDeath", entity.position
