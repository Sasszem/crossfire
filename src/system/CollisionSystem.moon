class VelocitySystem
    update: (dt) =>
        for entity in *@pool.groups.collision.entities
            for other in *@pool.groups.collision.entities
                if other == entity
                    continue
                distance = (entity.position - other.position)\length!
                if distance <= entity.collision_radius + other.collision_radius
                    @pool\emit "collision", entity, other