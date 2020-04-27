require("src.utils")

local C = require "src.Components"
local buildEntity = require "src.entity.buildEntity"

local states = {"Ghost", "Buster", "Shield", "Life"}

local primaryColors = {
    Ghost =     rgb(153, 0, 204),
    Buster =    rgb(204, 51, 0),
    Shield =    rgb(0, 204, 0),
    Life =      rgb(0, 204, 0),
}

local secondaryColors = {
    Ghost =     rgb(204, 0, 153, 128),
    Buster =    rgb(255, 102, 0, 128),
    Shield =    rgb(204, 0, 0, 128),
    Life =      rgb(0, 51, 0),
}

local Powerup = {}
Powerup.__index = Powerup

function Powerup:new(position, score)
    local ent = buildEntity("Powerup",
        C.PositionComponent(position),
        C.CollisionComponent(15),
        C.DespawnComponent(math.max(5, 10-math.floor(score/500))),
        { state = states[math.random(1,4)] },
        {
            drawLayer = 2,
        })
    setmetatable(ent, Powerup)
    return ent
end


function Powerup:draw()
    love.graphics.setColor(secondaryColors[self.state])
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.position.x, self.position.y, 15)
    love.graphics.circle("line", self.position.x, self.position.y, 15)
    love.graphics.setColor(primaryColors[self.state])
    love.graphics.circle("fill", self.position.x, self.position.y, 10)
    love.graphics.circle("line", self.position.x, self.position.y, 10)
end

setmetatable(Powerup, {__call = Powerup.new})
return Powerup
