
local font
if love
    font = love.graphics.newFont "asset/DigitFont.ttf", 50

class ScoreDrawer
    draw: =>
        love.graphics.push!
        love.graphics.origin!
        love.graphics.printf("#{@pool.data.score}", font, (@pool.data.w/2)-50, 10, 100, "center")
        love.graphics.pop!
