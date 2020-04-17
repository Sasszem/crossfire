--- Update @{src.entity.enemy.Enemy} shoot cooldowns and shoot @{src.entity.bullet.Bullet}s
-- Also works for @{src.entity.enemy.BigEnemy}es and @{src.entity.bullet.ExplodingBullet}s
-- @classmod src.system.enemy.Shoot

Vec2 = require "src.Vec2"

class Shoot
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.shoot.entities
            with entity
                if .state!="locked"
                    .shoot_cooldown = math.max(.shoot_cooldown, 0.5)
                    continue
                .shoot_cooldown -= dt
                if .shoot_cooldown <= 0 
                    dP = Vec2.fromAngle(.angle, 50)
                    @pool\queue .bullet(.position+dP, .angle, entity)
                    .shoot_cooldown += .refire_rate
        @pool\flush!
