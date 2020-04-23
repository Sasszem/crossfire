require("src.utils")

local Playfield = {}
Playfield.__index = Playfield

function Playfield:new(game, o)
    o = o or {game = game, D = game.config.wallSize}
    setmetatable(o, Playfield)
    return o
end

function Playfield:drawWalls()
    love.graphics.setColor(rgb(0, 193, 193))
    love.graphics.setLineWidth(10)
    love.graphics.line( -self.D, -self.D, -self.D,  self.D )
    love.graphics.line( -self.D,  self.D,  self.D,  self.D )
    love.graphics.line(  self.D,  self.D,  self.D, -self.D ) 
    love.graphics.line(  self.D, -self.D, -self.D, -self.D )
end


function Playfield:drawBackground()
    local pos = self.game.player.position
    local D = self.D

    love.graphics.setLineWidth(1)
    love.graphics.setColor(rgb(0, 204, 204))

    for i=-D, D, 50 do
        love.graphics.line(-D, i, D, i)
        love.graphics.line(i, -D, i, D)
    end

    love.graphics.setColor(rgb(0, 0, 153))
    love.graphics.setLineWidth(3)
    for i=-D, D, 100 do
        love.graphics.line(-D, i, D, i)
        love.graphics.line(i, -D, i, D)
    end
end

function Playfield:draw()
    self:drawBackground()
    self:drawWalls()
end

return Playfield