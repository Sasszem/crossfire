--- Bullets are shot by @{src.entity.enemy.Enemy}s
-- @classmod src.entity.bullet.Bullet

require "src.utils"

local buildEntity = require "src.entity.buildEntity"
local C = require "src.Components"

local Bullet = {}
Bullet.__index = Bullet


function Bullet:new(position, angle, parent)
    angle = angle or 0
    local ent = buildEntity("Bullet",
        C.PositionComponent(position),
        C.VelocityComponent.fromPolar(angle, 40),
        C.CollisionComponent(10),
        C.DespawnComponent(15),
        C.BulletComponent(),
        {
            parent = parent,
            drawLayer = 1,
        })
    setmetatable(ent, Bullet)
    return ent
end


function Bullet:update(dt)
    if self.despawnTimer <= 1 then
        self.collisionRadius = 0
    end
end


function Bullet:draw()
    local t = 0

    if self.despawnTimer <= 1 then
        t = 1 - self.despawnTimer
    end

    love.graphics.setColor(rgb(153+t*102, 255*t, 255*t, 255-255*t))
    love.graphics.circle("fill", self.position.x, self.position.y, 10-5*t)
    love.graphics.setLineWidth(1)
    love.graphics.circle("line", self.position.x, self.position.y, 10-5*t)
end


setmetatable(Bullet, {__call = Bullet.new})
return Bullet