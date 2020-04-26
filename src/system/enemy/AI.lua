require "src.utils"

local Vec2 = require "src.Vec2"

local EnemyAI = {}

function EnemyAI:update(dt)
    local player = self.pool.groups.player.entities[1]
    for _, enemy in ipairs(self.pool.groups.enemy.entities) do
        -- grab the player, also the difference vector to it
        local diff = player.position - enemy.position
        self:stateTransitions(enemy, player, diff)
        self[enemy.state .. "State"](self, enemy, player, diff, dt)
    end
end

function EnemyAI:stateTransitions(enemy, player, diff)
    local mt = enemy.movetarget
    if player.state=="Buster" then
        mt = 1000
    end

    -- if need to move
    if enemy.state=="aim" or enemy.state=="locked" then
        if math.abs(diff:length()-mt)>enemy.movetreshold then
            if mt-diff:length() > enemy.movetreshold and enemy.wallTouch then
                return
            end
            enemy.state = "move"
            return
        end
    end

    if enemy.state=="locked" then
        -- break locking if need to aim
        if math.abs(diff:angle()-enemy.angle)>enemy.turntreshold then
            enemy.state = "aim"
            return
        end
    end

    -- if need to turn
    if enemy.state=="move" then
        -- too close or too away?
        if diff:length() < mt then
            -- need to turn away
            if math.abs(cropAngle(diff:angle()+180)-enemy.angle)>5*enemy.turntreshold then
                enemy.state = "turn"
                enemy.velocity = Vec2(0,0)
                return
            end
        else
            -- need to turn to the player
            if math.abs(diff:angle()-enemy.angle)>5*enemy.turntreshold then
                enemy.state = "turn"
                enemy.velocity = Vec2(0,0)
            end
        end
    end
end

function EnemyAI:lockedState(enemy, player, diff, dt)

end

function EnemyAI:aimState(enemy, player, diff, dt)
    -- aim logic
    
    -- finished aiming
    if math.abs(enemy.angle - diff:angle())<1 then
        enemy.state = "locked"
        return
    end

    -- aim towards the player
    enemy.angle = enemy.angle + sign(diff:angle() - enemy.angle) * enemy.turnrate * dt
    enemy.angle = cropAngle(enemy.angle)
end

function EnemyAI:moveState(enemy, player, diff, dt)
    -- move logic

    local mt = enemy.movetarget
    if player.state=="Buster" then
        mt = 1000
    end

    -- finished moving
    if math.abs(diff:length()-mt)<1 or (diff:length()<mt and enemy.wallTouch) then
        enemy.state="aim"
        enemy.velocity = Vec2(0, 0)
        return
    end
    enemy.velocity = Vec2.fromAngle(enemy.angle, enemy.movespeed)
end

function EnemyAI:turnState(enemy, player, diff, dt)
    -- turn logic
    
    local mt = enemy.movetarget
    if player.state=="Buster" then
        mt = 1000
    end

    local turn_to = 0
    if diff:length() < mt then
        turn_to = diff:angle() + 180
    else
        turn_to = diff:angle()
    end
    turn_to = cropAngle(turn_to)

    -- finished turning
    if math.abs(enemy.angle - turn_to)<5*enemy.turntreshold then
        enemy.state = "move"
        return
    end

    -- turn it towards the target
    enemy.angle = enemy.angle + sign(turn_to - enemy.angle) * enemy.turnrate * dt
    enemy.angle = cropAngle(enemy.angle)
end

return EnemyAI
            
            

            

            
            
            

            
            
            