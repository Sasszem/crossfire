Game = require "src.Game"

function love.load() 
    w, h = love.graphics.getDimensions()
    game = Game(w, h)
end

function love.update(dt) 
    game:update(dt)
end

function love.draw()
    game:draw()
end