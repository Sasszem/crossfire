--- System to translate @{src.entity.bullet.Bullet}-@{src.entity.enemy.Enemy} and @{src.entity.bullet.Bullet}-@{src.entity.player.Player} collision events 
--- (but ignore @{src.entity.bullet.ExplodingBullet}s) to hit events
-- @classmod src.system.bullet.BulletCollisionResolver

class BulletExplosionSystem
    --- collision event handler
    -- @param first the first entity 
    -- @param second the second entity 
    collision: (bullet, victim) =>

        if not @pool.groups.enemy.hasEntity[victim] and not  @pool.groups.player.hasEntity[victim]
            return
        
        if not @pool.groups.explosion.hasEntity[bullet]
            return

        -- kill bullet
        bullet.despawnTimer = 0
        -- emit hit events for all entities in radius
        pos = bullet.position
        radius = bullet.explosion_radius
        for entity in *@pool.groups.despawn.entities
            if (entity.position-pos)\length! <= radius
                if not @pool.groups.bullet.hasEntity[entity]
                    @pool\emit "hit", entity
