require("src.utils")

local C = require "src.Components"
local buildEntity = require "src.entity.buildEntity"

local states = {"Ghost", "Buster", "Shield"}

local primaryColors = {
    Ghost =     rgb(153, 0, 204),
    Buster =    rgb(204, 51, 0),
    Shield =    rgb(0, 204, 0),
}

local secondaryColors = {
    Ghost =     rgb(204, 0, 153, 128),
    Buster =    rgb(255, 102, 0, 128),
    Shield =    rgb(204, 0, 0, 128),
}

local function Powerup(position)
    return buildEntity("Powerup",
        C.PositionComponent(position),
        C.CollisionComponent(15),
        C.DespawnComponent(10),
        { state = states[math.random(1,3)] }, 
        {
            draw = function (self)
                love.graphics.setColor(secondaryColors[self.state])
                love.graphics.circle("fill", self.position.x, self.position.y, 15)
                love.graphics.setColor(primaryColors[self.state])
                love.graphics.circle("fill", self.position.x, self.position.y, 10)
            end
        })
end

return Powerup
