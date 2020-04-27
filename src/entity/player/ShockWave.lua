require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local function ShockWave(position)
    return buildEntity("ShockWave", 
        C.PositionComponent(position),
        C.CollisionComponent(0),
        C.DespawnComponent(0.5),
        {
            update = function(self, dt)
                self.collision_radius = 1000 * self.age
            end,
            draw = function(self)
                love.graphics.setColor(rgb(255, 255, 255, 128 - self.age*200))
                love.graphics.circle("line", self.position.x, self.position.y, self.collision_radius)
            end
        })
end

return ShockWave
