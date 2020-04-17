--- System to translate @{src.entity.bullet.Bullet}-@{src.entity.enemy.Enemy} and @{src.entity.bullet.Bullet}-@{src.entity.player.Player} collision events 
--- (but ignore @{src.entity.bullet.ExplodingBullet}s) to hit events
-- @classmod src.system.bullet.BulletCollisionResolver

class BulletCollisionResolver
    --- collision event handler
    -- @param first the first entity 
    -- @param second the second entity 
    collision: (bullet, victim) => 

        if bullet.type != "Bullet"
            return
        if not @pool.groups.target.hasEntity[victim]
            return

        -- ignore if it's the enemy's own bullet
        if bullet.parent == victim
            return
        
        -- ignore shield and ghost player - bullet collisions
        if @pool.groups.player.hasEntity[victim] and ( victim.state == "Shield" or victim.state=="Ghost" )
            return

        -- kill bullet
        bullet.despawnTimer = 0
        @pool\emit "hit", victim

