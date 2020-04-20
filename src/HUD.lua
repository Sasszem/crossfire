
local HUD = {}
HUD.__index = HUD

local powerupColors = {
    Buster = rgb(128, 0, 0, 128),
    Ghost = rgb(204, 51, 153, 128),
    Shield = rgb(102, 255, 51, 128),
}

function HUD:new(game, o)
    o = o or {
        game=game,
        font_50 = love.graphics.newFont("asset/DigitFont.ttf", 50),
        font_20 = love.graphics.newFont("asset/DigitFont.ttf", 30),
    }
    setmetatable(o, HUD)
    return o
end

function HUD:drawPowerupTimer()
    if self.game.player.state=="Normal" then
        return
    end
    local w = (self.game.w-40) * (self.game.player.powerupCancel/30)
    love.graphics.setColor(powerupColors[self.game.player.state])
    love.graphics.rectangle("fill", 20, self.game.h-30, w, 20)
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", 20, self.game.h-30, self.game.w-40, 20)
end

function HUD:draw()
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.printf(tostring(self.game.score), self.font_50, (self.game.w/2)-100, 10, 200, "center")
    love.graphics.printf(tostring(self.game.player.lives).." lives", self.font_20, (self.game.w)-120, 20, 120, "left")
    self:drawPowerupTimer()
end

function HUD:debugDraw()
    love.graphics.setColor(rgb(255, 0, 0))
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
end

return HUD