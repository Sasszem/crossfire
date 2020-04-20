require("src.utils")

local Playfield = {}
Playfield.__index = Playfield

function Playfield:new(game, o)
    o = o or {game = game}
    setmetatable(o, Playfield)
    return o
end

local D = 400

function Playfield:drawWalls() 
    love.graphics.setColor(rgb(255, 0, 102))
    love.graphics.setLineWidth(10)
    love.graphics.line( -D, -D, -D,  D )
    love.graphics.line( -D,  D,  D,  D )
    love.graphics.line(  D,  D,  D, -D ) 
    love.graphics.line(  D, -D, -D, -D )
end


function Playfield:drawBackground()
    local pos = self.game.player.position
    
    love.graphics.setLineWidth(1)
    love.graphics.setColor(rgb(0, 204, 204))
    
    beginX = math.floor((pos.x - 500) / 50) * 50
    beginY = pos.y - 400
    endY = pos.y + 400
    for i = 0, 20 do
        x = beginX + 50*i
        love.graphics.line(x, beginY, x, endY)
    end

    beginY =  math.floor((pos.y - 400) / 50) * 50
    beginX = pos.x - 500
    endX = pos.x + 500
    for i = 0, 16 do
        y = beginY + 50 * i
        love.graphics.line(beginX, y, endX, y)
    end

    love.graphics.setColor(rgb(204, 41, 0))
    love.graphics.setLineWidth(3)
    beginX = math.floor((pos.x - 500) / 100) * 100
    for i = 0, 10 do
        x = beginX + 100*i
        love.graphics.line(x, beginY, x, endY)
    end
        
    beginY =  math.floor((pos.y - 400) / 100) * 100
    beginX = pos.x - 500
    endX = pos.x + 500
    for i = 0, 16 do
        y = beginY + 100 * i
        love.graphics.line(beginX, y, endX, y)
    end
end

function Playfield:draw()
    self:drawBackground()
    self:drawWalls()
end

return Playfield