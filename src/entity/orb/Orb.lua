--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s
-- and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

local Vec2 = require("src.Vec2")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local Orb = {}
Orb.__index = Orb


function Orb:new(position, score)
    score = score or 0
    local s = math.floor(score / 500)
    local despawnTime = math.random(math.max(5, 10-s), math.max(10, 20-s))
    local ent = buildEntity("Orb",
        C.PositionComponent(position),
        C.CollisionComponent(7),
        C.DespawnComponent(despawnTime)
    )
    setmetatable(ent, Orb)
    return ent
end


function Orb:update(dt)
    self.position = self.position + Vec2(math.random()-0.5, math.random()-0.5)*50*dt
end


function Orb:draw()
    if self.age < 0.2 then
        return
    end
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.position.x, self.position.y, 5)
    love.graphics.circle("line", self.position.x, self.position.y, 5)
    love.graphics.setColor(rgb(255, 255, 255, 128))
    love.graphics.circle("fill", self.position.x, self.position.y, 7)
    love.graphics.circle("line", self.position.x, self.position.y, 7)
end


setmetatable(Orb, {__call = Orb.new})
return Orb
