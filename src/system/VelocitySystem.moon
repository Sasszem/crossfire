class VelocitySystem
    update: (dt) =>
        for entity in *@pool.groups.velocity.entities
            with entity
                .position += .velocity * dt        