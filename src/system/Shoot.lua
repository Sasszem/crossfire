--- Update @{src.entity.enemy.Enemy} shoot cooldowns and shoot @{src.entity.bullet.Bullet}s
-- Also works for @{src.entity.enemy.BigEnemy}es and @{src.entity.bullet.ExplodingBullet}s
-- @classmod src.system.enemy.Shoot

local Vec2 = require "src.Vec2"

local Shoot = {}

--- update event handler
-- @tparam number dt delta-time since prev. call
function Shoot:update(dt)
    for _, entity in ipairs(self.pool.groups.shoot.entities) do
        if entity.state=="locked" or entity.state=="aim" then
            entity.shoot_cooldown = entity.shoot_cooldown - dt
            if entity.shoot_cooldown <= 0 then
                local dP = Vec2.fromAngle(entity.angle, 50)
                self.pool:queue(entity.bullet(entity.position+dP, entity.angle, entity))
                entity.shoot_cooldown = entity.shoot_cooldown + entity.refire_rate
            end
        else
            entity.shoot_cooldown = math.max(entity.shoot_cooldown, 0.5)
        end
    end
end

return Shoot