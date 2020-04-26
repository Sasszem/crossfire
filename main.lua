Game = require "src.Game"

function love.load() 
    love.window.setTitle("Crossfire")
    succ = love.window.setIcon(love.image.newImageData("asset/icon.png"))
    w, h = love.graphics.getDimensions()
    love.keyboard.setKeyRepeat(true)
    game = Game(w, h)
end

function love.update(dt) 
    game:update(dt)
end

function love.keypressed(key, _, rep)
    game:keypressed(key, rep)
end

function love.mousepressed( x, y, button, istouch, presses )
    game:mousepressed( x, y, button, istouch, presses )
end

function love.mousereleased( x, y, button, istouch, presses )
    game:mousereleased( x, y, button, istouch, presses )
end

function love.draw()
    game:draw()
end
