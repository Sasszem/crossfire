--- System to translate @{src.entity.bullet.Bullet}-@{src.entity.enemy.Enemy} and @{src.entity.bullet.Bullet}-@{src.entity.player.Player} collision events 
--- (but ignore @{src.entity.bullet.ExplodingBullet}s) to hit events
-- @classmod src.system.bullet.ExplosionSpawner

Explosion = require "src.entity.bullet.Explosion"

class ExplosionSpawner
    --- collision event handler
    -- @param first the first entity 
    -- @param second the second entity 
    collision: (bullet, victim) =>

        if not @pool.groups.target.hasEntity[victim]
            return
        
        if not @pool.groups.explosion.hasEntity[bullet]
            return

        -- kill bullet
        bullet.despawnTimer = 0
        @pool\queue Explosion(bullet.position, bullet.parent)
    