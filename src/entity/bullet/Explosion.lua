require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local Explosion = {}
Explosion.__index = Explosion


function Explosion:new(position, parent)
    local ent = buildEntity("Explosion",
        C.PositionComponent(position),
        C.CollisionComponent(0),
        C.DespawnComponent(1),
        {
            seen = {},
            parent = parent
        })
    setmetatable(ent, Explosion)
    return ent
end


function Explosion:update(dt)
    self.collisionRadius = 100*self.age
end


function Explosion:draw()
    love.graphics.setColor(rgb(255, 76, 76, 128-64*self.age))
    love.graphics.setLineWidth(3)
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
end


setmetatable(Explosion, {__call = Explosion.new})
return Explosion
