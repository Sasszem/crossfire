--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet

require "src.utils"

local buildEntity = require "src.entity.buildEntity"
local C = require "src.Components"

local function Bullet(position, angle, parent)
    angle = angle or 0
    return buildEntity("Bullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.DespawnComponent(15),
        C.BulletComponent(),
        {
            parent = parent,
            drawLayer = 1,
            draw = function(self)
                local t = 0
                if self.despawnTimer <= 1 then
                    t = 1 - self.despawnTimer
                end
                love.graphics.setColor(rgb(153+t*102, 255*t, 255*t, 255-255*t))
                love.graphics.circle("fill", self.position.x, self.position.y, 10-5*t)
                love.graphics.setLineWidth(1)
                love.graphics.circle("line", self.position.x, self.position.y, 10-5*t)
            end,
            update = function(self, dt)
                if self.despawnTimer <= 1 then
                    self.collision_radius = 0
                end
            end
        })
end

return Bullet