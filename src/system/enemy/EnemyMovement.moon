Vec2 = require "src.Vec2"

class EnemyMovement
    update: (dt) =>
        for entity in *@pool.groups.enemy.entities
            with entity
                .velocity = Vec2.fromAngle(.aim) * .speed