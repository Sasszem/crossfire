--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local function ExplodingBullet(position, angle, parent)
    angle = angle or 0
    return buildEntity("ExplodingBullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.ExplosionComponent(50),
        C.DespawnComponent(10),
        C.BulletComponent(),
        {
            drawLayer = 1,
            parent = parent,
            draw = function(self)
                local t = 0
                if self.despawnTimer < 1 then
                    t = 1-self.despawnTimer
                end
                love.graphics.setColor(rgb(0, 153, 255, 128-t*128))
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", self.position.x, self.position.y, 14)
                love.graphics.circle("line", self.position.x, self.position.y, 14)
                love.graphics.setColor(rgb(0, 0, 255, 255-t*255))
                love.graphics.circle("fill", self.position.x, self.position.y, 10)
                love.graphics.circle("line", self.position.x, self.position.y, 10)
            end, 
            update = function(self, dt)
                if self.despawnTimer <= 1 then
                    self.collision_radius = 0
                end
            end
        })
end


return ExplodingBullet