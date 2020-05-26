--- Enemyes shoot @{src.entity.bullet.Bullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.Enemy

require("src.utils")

local Vec2 = require("src.Vec2")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local Bullet = require("src.entity.bullet.Bullet")

local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(position, angle)
    angle = angle or math.random(0, 360)
    local ent = buildEntity("Enemy",
        C.PositionComponent(position),
        C.DirectionComponent(angle),
        C.CollisionComponent(30),
        C.ShootComponent(Bullet, 4, "shoot"),
        C.DespawnComponent(),
        C.TargetComponent(),
        C.EnemyAI(200, 40, 120, 70, 2)
    )
    setmetatable(ent, Enemy)
    return ent
end


function Enemy:draw()
    local primary_color = rgb(255, 204, 0)
    local secondary_color = rgb(230, 180, 0)

    if self.age<0.2 then
        local t = self.age * 5
        primary_color = rgb(255, 255-51*t, 255-255*t)
    end

    if self.despawnTimer ~= -1 then
        local t = self.despawnTimer * 5
        primary_color = rgb(255, 204*t, 0)
    end

    love.graphics.setColor(primary_color)
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.position.x, self.position.y, 30)
    love.graphics.setColor(secondary_color)
    --love.graphics.setColor(rgb(204, 102, 0))
    love.graphics.circle("line", self.position.x, self.position.y, 30)

    local fr = self.position + Vec2.fromAngle(self.angle, 30)
    local to = self.position + Vec2.fromAngle(self.angle, 50)
    love.graphics.setLineWidth(10)
    love.graphics.line(fr.x, fr.y, to.x, to.y)

    fr = self.position + Vec2.fromAngle(self.angle, 29)
    to = self.position + Vec2.fromAngle(self.angle, 49)
    love.graphics.setLineWidth(8)
    love.graphics.setColor(primary_color)
    love.graphics.line(fr.x, fr.y, to.x, to.y)
end


setmetatable(Enemy, {__call = Enemy.new})
return Enemy
