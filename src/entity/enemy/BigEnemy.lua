--- BigEnemyes shoot @{src.entity.bullet.ExplodingBullet}s at the @{src.entity.player.Player}
-- @classmod src.entity.enemy.BigEnemy

require("src.utils")

local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local Vec2 = require("src.Vec2")

local ExplodingBullet = require("src.entity.bullet.ExplodingBullet")

local BigEnemy = {}
BigEnemy.__index = BigEnemy


function BigEnemy:new(position, angle)
    angle = angle or math.random(0, 360)
    local ent = buildEntity("BigEnemy",
        C.PositionComponent(position),
        C.DirectionComponent(angle),
        C.CollisionComponent(30),
        C.ShootComponent(ExplodingBullet, 7, "bigShoot"),
        C.DespawnComponent(),
        C.TargetComponent(),
        C.EnemyAI(250, 30, 90, 60, 10)
    )
    setmetatable(ent, BigEnemy)
    return ent
end


function BigEnemy:draw()
    local primary_color = rgb(255, 102, 0)
    local secondary_color = rgb(210, 90, 0)

    if self.age<0.2 then
        local t = self.age * 5
        primary_color = rgb(255, 255-153*t, 255-255*t)
    end

    if self.despawnTimer ~= -1 then
        local t = self.despawnTimer * 5
        primary_color = rgb(255, 102*t, 0)
    end

    love.graphics.setColor(primary_color)
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.position.x, self.position.y, 30)
    --love.graphics.setColor(rgb(204, 0, 0))
    love.graphics.setColor(secondary_color)
    love.graphics.circle("line", self.position.x, self.position.y, 30)

    local fr = self.position + Vec2.fromAngle(self.angle, 30)
    local to = self.position + Vec2.fromAngle(self.angle, 50)
    love.graphics.setLineWidth(14)
    love.graphics.line(fr.x, fr.y, to.x, to.y)

    fr = self.position + Vec2.fromAngle(self.angle, 29)
    to = self.position + Vec2.fromAngle(self.angle, 49)
    love.graphics.setLineWidth(12)
    love.graphics.setColor(primary_color)
    love.graphics.line(fr.x, fr.y, to.x, to.y)
end

setmetatable(BigEnemy, {__call = BigEnemy.new})
return BigEnemy
