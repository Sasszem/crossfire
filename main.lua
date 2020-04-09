Game = require "src.Game"

function love.load() 
    w, h = love.graphics.getDimensions()
    love.keyboard.setKeyRepeat(true)
    game = Game(w, h)
end

local update = true

function love.update(dt) 
    if update then
        game:update(dt)
    end
end

function love.keypressed(key, _, rep)
    if key=="return" and not rep then
        update = not update
        return
    end
    if key=="space" then
        game:update(0.001)
    else 
        game:update(0.1)
    end
end

function love.draw()
    game:draw()
end