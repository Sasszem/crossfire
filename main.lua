local Crossfire = require "src.Crossfire"

local CR = nil

function love.load()
    CR = Crossfire()
    CR:init()
end

function love.update(dt)
    CR:update(dt)
end

function love.keypressed(key, code, rep)
    CR:keypressed(key, code, rep)
end

function love.mousepressed( x, y, button, istouch, presses )
    CR:mousepressed( x, y, button, istouch, presses )
end

function love.mousereleased( x, y, button, istouch, presses )
    CR:mousereleased( x, y, button, istouch, presses )
end

function love.textinput(t)
    CR:textinput(t)
end

function love.draw()
    CR:draw()
end
