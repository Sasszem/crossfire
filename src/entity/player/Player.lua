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

local Player = {}
Player.__index = Player


function Player:new(position, angle)
    angle = angle or 0
    local ent = buildEntity("Player",
        C.PositionComponent(position),
        C.VelocityComponent(),
        C.CollisionComponent(40),
        C.DirectionComponent(angle),
        C.DespawnComponent(),
        C.TargetComponent(),
        C.LivesCounterComponent(),
        {
            state = "Normal",
            powerupCancel = -1,
            hitCooldown = 0,
            drawLayer = 5,
        })
    setmetatable(ent, Player)
    return ent
end


function Player:draw()
    local fadeFactor = math.min((5 - self.hitCooldown)/4, 1)
    if fadeFactor < 0.2 then
        fadeFactor = 0
    end

    love.graphics.setColor(fade(colors[self.state], fadeFactor))
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.position.x, self.position.y, self.collisionRadius)
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
    local where = self.position + Vec2.fromAngle(self.angle, self.collisionRadius - 10)
    local delta = Vec2.fromAngle(self.angle + 90, 7)
    local point = where + delta
    love.graphics.setColor(fade(rgb(0,0,0), fadeFactor))
    love.graphics.circle("fill", point.x, point.y, 5)
    love.graphics.circle("line", point.x, point.y, 5)
    point = where - delta
    love.graphics.circle("fill", point.x, point.y, 5)
    love.graphics.circle("line", point.x, point.y, 5)

    if self.state=="Shield" then
        love.graphics.setColor(fade(rgb(255, 0, 0), fadeFactor))
        love.graphics.setLineWidth(3)
        love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
    end
end

setmetatable(Player, {__call = Player.new})
return Player