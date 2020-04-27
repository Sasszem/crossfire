--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

require("src.utils")

local Vec2 = require("src.Vec2")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local colors = {
    Normal = rgb(51, 102, 255),
    Buster = rgb(128, 0, 0),
    Ghost =  rgb(204, 51, 153, 128),
    Shield = rgb(102, 255, 51),
}

local function Player(position, angle)
    angle = angle or 0
    return buildEntity("Player",
        C.PositionComponent(position),
        C.VelocityComponent(),
        C.CollisionComponent(40),
        C.DirectionComponent(),
        C.DespawnComponent(),
        C.TargetComponent(),
        C.LivesCounterComponent(),
        {
            state = "Normal",
            powerupCancel = -1,
            hitCooldown = 0,
            drawLayer = 5,
            draw = function(self)
                
                local fadeFactor = math.min((5 - self.hitCooldown)/4, 1)
                if fadeFactor < 0.2 then
                    fadeFactor = 0
                end

                love.graphics.setColor(fade(colors[self.state], fadeFactor))
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", self.position.x, self.position.y, self.collision_radius)
                love.graphics.circle("line", self.position.x, self.position.y, self.collision_radius)
                local where = self.position + Vec2.fromAngle(self.angle, self.collision_radius - 10)
                love.graphics.setColor(fade(rgb(0,0,0), fadeFactor))
                love.graphics.circle("fill", where.x, where.y, 5)
                love.graphics.circle("line", where.x, where.y, 5)
                
                if self.state=="Shield" then
                    love.graphics.setColor(fade(rgb(255, 0, 0), fadeFactor))
                    love.graphics.setLineWidth(3)
                    love.graphics.circle("line", self.position.x, self.position.y, self.collision_radius)
                end
            end,
            update = function(self, dt)
                if self.hitCooldown > -1 then
                    self.hitCooldown = self.hitCooldown - dt
                end
            end
        })
end

return Player