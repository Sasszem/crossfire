Game = require "src.Game"

function love.load() 
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

function love.draw()
    game:draw()
end
