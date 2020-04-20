
--- System for detecting collisions and dispatching collision events
-- @classmod src.system.CollisionSystem
class CollisionSystem
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.collision.entities
            for other in *@pool.groups.collision.entities
                if other == entity
                    continue
                if other.collision_radius==0 or entity.collision_radius==0
                    continue

                distance = (entity.position - other.position)\length!
                if distance <= entity.collision_radius + other.collision_radius
                    @pool\emit "collision", entity, other