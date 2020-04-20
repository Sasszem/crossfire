import max, min, abs from math

class Wall
    init: =>
        @size = 400
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

            ent.wallCollision = (abs(ent.position.x)>=s) or (abs(ent.position.y)>=s)
            
            if @pool.groups.bullet.hasEntity[ent]
                continue

            x = min x, s
            x = max x, -s
            y = min y, s
            y = max y, -s
            ent.position.x = x
            ent.position.y = y