import max, min, abs from math

class Wall
    init: =>
        @size = 200
    update: (dt) =>
        for ent in *@pool.groups.position.entities
            -- ignore ShockWave
            if ent.type=="ShockWave"
                continue

            x = ent.position.x
            y = ent.position.y
            s = @size
            if ent.collision_radius
                s -= ent.collision_radius
            if @pool.groups.bullet.hasEntity[ent]
                if abs(x) > s or abs(y) > s
                    -- despawn bullet
                    ent.despawnTimer = 0
            x = min x, s
            x = max x, -s
            y = min y, s
            y = max y, -s
            ent.position.x = x
            ent.position.y = y
