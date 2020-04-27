--- ExplodingBullets are shot by @{src.entity.enemy.BigEnemy}s
-- @classmod src.entity.bullet.ExplodingBullet

require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local ExplodingBullet = {}
ExplodingBullet.__index = ExplodingBullet


function ExplodingBullet:new(position, angle, parent)
    angle = angle or 0
    local ent = buildEntity("ExplodingBullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.DespawnComponent(10),
        C.BulletComponent(),
        {
            drawLayer = 1,
            parent = parent,
        })
    setmetatable(ent, ExplodingBullet)
    return ent
end


function ExplodingBullet:update(dt)
    if self.despawnTimer <= 1 then
        self.collisionRadius = 0
    end
end


function ExplodingBullet:draw()
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
end


setmetatable(ExplodingBullet, {__call=ExplodingBullet.new})
return ExplodingBullet