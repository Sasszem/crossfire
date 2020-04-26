local Vec2 = require("src.Vec2")

local PlayerMovement = {}

function PlayerMovement:init()
    self.w = self.pool.data.w
    self.h = self.pool.data.h
end

function PlayerMovement:update(dt) 
    local mx, my = love.mouse.getPosition()
    local angle = Vec2(mx-self.w/2, my-self.h/2):angle()
    for _, p in ipairs(self.pool.groups.player.entities) do
        local v = 45
        if p.state == "Buster" then
            v = 80
        end

        if self.pool.data.slowdown then
            v = v/self.pool.data.slowdownFactor
        end
        
        p.velocity = Vec2.fromAngle(angle, v)
        p.angle = angle
    end
end

return PlayerMovement