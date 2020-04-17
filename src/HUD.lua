
local HUD = {}
HUD.__index = HUD

local font = love.graphics.newFont("asset/DigitFont.ttf", 50)

function HUD:new(game, o)
    o = o or {game=game}
    setmetatable(o, HUD)
    return o
end

function HUD:draw()
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.printf(tostring(self.game.score), font, (self.game.w/2)-50, 10, 100, "center")
end

function HUD:debugDraw()
    love.graphics.setColor(rgb(255, 0, 0))
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
end

return HUD