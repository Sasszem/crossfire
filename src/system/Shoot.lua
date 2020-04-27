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
            entity.shootCooldown = entity.shootCooldown - dt
            if entity.shootCooldown <= 0 then
                local dP = Vec2.fromAngle(entity.angle, 50)
                self.pool:queue(entity.bullet(entity.position+dP, entity.angle, entity))
                entity.shootCooldown = entity.shootCooldown + entity.refireRate
            end
        else
            entity.shootCooldown = math.max(entity.shootCooldown, 0.5)
        end
    end
end

return Shoot