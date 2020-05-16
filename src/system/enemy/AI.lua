require "src.utils"

local Vec2 = require "src.Vec2"

local EnemyAI = {}

local function closestAngle(from, to)
    -- return an angle that is congruent to to % 360
    -- but means the correct turning way

    if math.abs(from-to)>180 then
        -- turning directly would be the stupid version
        if from>to then
            return to + 360, math.abs(to + 360 - from)
        end
        return to - 360, math.abs(to - 360 - from)
    end
    -- turning directly is the smart way
    return to, math.abs(to - from)
end

local function cleanup(enemy)
    return function()
        -- crop the angle in the [0, 360[ range after a tween
        enemy.angle = cropAngle(enemy.angle)
        enemy.state = "locked"
        enemy.targetPoint = nil
        enemy.tween = nil
    end
end

function EnemyAI:update(dt)
    local player = self.pool.groups.player.entities[1]
    for _, enemy in ipairs(self.pool.groups.enemy.entities) do
        -- grab the player, also the difference vector to it
        local diff = player.position - enemy.position
        self:aimEnemy(enemy, player, diff)
        self:moveEnemy(enemy, player, diff)
    end
end

function EnemyAI:aimEnemy(enemy, player, diff)
    -- only care about locked enemies
    if enemy.state ~= "locked" then
        return
    end

    -- check if even need to aim
    if math.abs(diff:angle() - enemy.angle)>enemy.turntreshold then
        local target, delta = closestAngle(enemy.angle, diff:angle())
        local t = delta / enemy.turnrate

        enemy.state = "aim"

        --set up interpolation between angles
        enemy.tween = flux.to(enemy, t, {angle=target})
        enemy.tween:ease("linear")
        enemy.tween:oncomplete(cleanup(enemy))
    end
end

local function setupMoveTween(enemy, tMove, targetPoint)
    -- setup second tween
    -- had a problem with :after - :oncompleate firing at first tween completion
    -- so used this as a workatound
    return function()
        enemy.tween = flux.to(enemy.position, tMove, {x=targetPoint.x, y=targetPoint.y})
        enemy.tween:ease("linear")
        enemy.tween:oncomplete(cleanup(enemy))
    end
end

function EnemyAI:moveEnemy(enemy, player, diff)
    -- ignore if already moving
    if enemy.state == "moveTurn" then
        return
    end

    -- buster player run-away
    local mt = enemy.movetarget
    if player.state=="Buster" then
        mt = 1000
    end

    -- if need to move
    if math.abs(diff:length()-mt)>enemy.movetreshold then

        -- ignore at walls
        if mt-diff:length() > enemy.movetreshold and enemy.wallTouch then
            return
        end

        -- stop existint tween (aiming)
        if enemy.tween then
            enemy.tween:stop()
            cleanup(enemy)()
        end

        enemy.state = "moveTurn"

        -- pick a target to move to
        local angle = cropAngle(180 + diff:angle())
        angle = math.random(angle - 15, angle + 15)
        local dist = enemy.movetarget
        dist = math.random(dist - 30, dist + 30)

        -- calculate target vector and point
        local targetVectorPlayer = Vec2.fromAngle(angle, dist) -- from player
        local targetPoint = player.position + targetVectorPlayer

        -- limit target into walls, including collision radius
        local s = self.pool.data.config.wallSize - enemy.collisionRadius
        targetPoint.x = math.min(targetPoint.x, s)
        targetPoint.x = math.max(targetPoint.x, -s)
        targetPoint.y = math.min(targetPoint.y, s)
        targetPoint.y = math.max(targetPoint.y, -s)

        -- save target point for debug draw
        enemy.targetPoint = targetPoint

        -- target vector from enemy
        local targetVectorEnemy = targetPoint - enemy.position

        -- calculate turn towards that point
        local targetAngle, delta = closestAngle(enemy.angle, targetVectorEnemy:angle())
        local tTurn = delta / enemy.turnrate

        -- calculate moving towards that point
        local len = targetVectorEnemy:length()
        local tMove = len / enemy.movespeed

        -- setup tween
        enemy.tween = flux.to(enemy, tTurn, {angle = targetAngle})
        enemy.tween:ease("linear")
        enemy.tween:oncomplete(setupMoveTween(enemy, tMove, targetPoint))
    end
end

function EnemyAI:debugDraw()
    love.graphics.setColor(rgb(0, 255, 255))
    for _, enemy in ipairs(self.pool.groups.enemy.entities) do
        if enemy.state == "moveTurn" then
            love.graphics.circle("fill", enemy.targetPoint.x, enemy.targetPoint.y, 10)
            love.graphics.line(enemy.targetPoint.x, enemy.targetPoint.y, enemy.position.x, enemy.position.y)
        end
    end
end

return EnemyAI