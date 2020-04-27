--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

local Vec2 = require("src.Vec2")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local function Orb(position, score)
    score = score or 0
    return buildEntity("Orb", 
        C.PositionComponent(position),
        C.CollisionComponent(7),
        C.DespawnComponent(math.random(math.max(5, 10-math.floor(score / 500)), math.max(10, 20-math.floor(score / 500)))),
        {
            draw = function(self)
                if self.age < 0.2 then
                    return
                end
                love.graphics.setColor(rgb(255, 255, 255))
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", self.position.x, self.position.y, 5)
                love.graphics.circle("line", self.position.x, self.position.y, 5)
                love.graphics.setColor(rgb(255, 255, 255, 128))
                love.graphics.circle("fill", self.position.x, self.position.y, 7)
                love.graphics.circle("line", self.position.x, self.position.y, 7)
            end,
            update = function(self, dt)
                self.position = self.position + Vec2(math.random()-0.5, math.random()-0.5)*50*dt
            end
    })
end

return Orb
