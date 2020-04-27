require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local ShockWave = {}
ShockWave.__index = ShockWave


function ShockWave:new(position)
    local ent = buildEntity("ShockWave",
        C.PositionComponent(position),
        C.CollisionComponent(0),
        C.DespawnComponent(0.5)
    )
    setmetatable(ent, ShockWave)
    return ent
end


function ShockWave:update(dt)
    self.collisionRadius = 1000 * self.age
end


function ShockWave:draw()
    love.graphics.setColor(rgb(255, 255, 255, 128 - self.age*200))
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
end


setmetatable(ShockWave, {__call = ShockWave.new})
return ShockWave
