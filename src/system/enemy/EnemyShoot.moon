--- Update @{src.entity.enemy.Enemy} shoot cooldowns and shoot @{src.entity.bullet.Bullet}s
-- Also works for @{src.entity.enemy.BigEnemy}es and @{src.entity.bullet.ExplodingBullet}s
-- @classmod src.system.enemy.EnemyShoot

class EnemyShoot
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.enemy.entities
            with entity
                .shoot_cooldown -= dt
                if .shoot_cooldown <= 0 
                    @pool\queue .bullet(.position, .angle)
                    .shoot_cooldown += .refire_rate
        @pool\flush!