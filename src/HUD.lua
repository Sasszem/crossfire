
local HUD = {}
HUD.__index = HUD

function HUD:new(game, o)
    o = o or {
        game=game,
        font_50 = love.graphics.newFont("asset/DigitFont.ttf", 50),
        font_20 = love.graphics.newFont("asset/DigitFont.ttf", 30),
    }
    setmetatable(o, HUD)
    return o
end

function HUD:draw()
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.printf(tostring(self.game.score), self.font_50, (self.game.w/2)-100, 10, 200, "center")
    love.graphics.printf(tostring(self.game.player.lives).." lives", self.font_20, (self.game.w)-120, 20, 120, "left")
end

function HUD:debugDraw()
    love.graphics.setColor(rgb(255, 0, 0))
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
end

return HUD