class FPSDrawer
    draw: =>
        love.graphics.push!
        love.graphics.origin!
        love.graphics.print("Current FPS: #{love.timer.getFPS!}", 10, 10)
        love.graphics.pop!