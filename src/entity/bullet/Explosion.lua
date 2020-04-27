require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

function Explosion(position, parent)
    return buildEntity("Explosion",
        C.PositionComponent(position),
        C.CollisionComponent(0),
        C.DespawnComponent(1),
        {
            seen = {},
            parent = parent
        },
        {
            update = function(self, dt)
                self.collision_radius = 100*self.age
            end,
            draw = function(self)
                love.graphics.setColor(rgb(255, 76, 76, 128-64*self.age))
                love.graphics.setLineWidth(3)
                love.graphics.circle("line", self.position.x, self.position.y, self.collision_radius)
            end
        })
end

return Explosion
