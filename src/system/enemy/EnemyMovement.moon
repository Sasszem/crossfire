--- Update enemy velocities from speed and aim
-- @classmod src.system.enemy.EnemyMovement

Vec2 = require "src.Vec2"

class EnemyMovement
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.enemy.entities
            with entity
                .velocity = Vec2.fromAngle(.angle, .speed)