Bullet = require "src.entity.bullet.Bullet"

class BulletCollisionResolver
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

