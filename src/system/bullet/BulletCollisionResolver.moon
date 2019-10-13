--- System to translate @{src.entity.bullet.Bullet}-@{src.entity.enemy.Enemy} and @{src.entity.bullet.Bullet}-@{src.entity.player.Player} collision events 
--- (but ignore @{src.entity.bullet.ExplodingBullet}s) to hit events
-- @classmod src.system.bullet.BulletCollisionResolver

Bullet = require "src.entity.bullet.Bullet"

class BulletCollisionResolver
    --- collision event handler
    -- @param first the first entity 
    -- @param second the second entity 
    collision: (first, second) =>
        bullet = nil
        victim = nil

        -- get bullet & shot entity
        if first.__class == Bullet
            bullet = first
            victim = second
        if second.__class == Bullet
            bullet = second
            victim = first
        
        if not victim
            return

        -- ignore bullet - bullet-class
        if @pool.groups.bullet.hasEntity[victim]
            return
        
        -- kill bullet
        bullet.despawnTimer = 0
        @pool\emit "hit", victim

