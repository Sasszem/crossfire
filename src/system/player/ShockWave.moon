class ShockWave
    collision: (wave, victim) =>
        -- only care about shockwave-collisions
        if wave.type!="ShockWave"
            return
        -- only care about despawnable entities
        if not @pool.groups.despawn.hasEntity[victim]
            return
        -- do not kill players
        if @pool.groups.player.hasEntity[victim]
            return

        -- hit entity
        @pool\emit "hit", victim

        -- despawn Bullets
        if @pool.groups.bullet.hasEntity[victim]
            victim.despawnTimer = 0
