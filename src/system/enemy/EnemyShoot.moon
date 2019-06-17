Vec2 = require "src.Vec2"

class EnemyMovement
    update: (dt) =>
        for entity in *@pool.groups.enemy.entities
            with entity
                .shoot_cooldown -= dt
                if .shoot_cooldown <= 0 
                    @pool\queue .bullet(.position, Vec2.fromAngle .aim)
                    .shoot_cooldown += .refire_rate
        @pool\flush!