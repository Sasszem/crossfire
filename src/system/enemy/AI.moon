Vec2 = require "src.Vec2"

sign = (num) ->
    if num>0
        return 1
    return -1

crop_angle = (angle) ->
    x = angle
    while x<-180
        x+=360
    while x>180
        x-=360
    return x

class EnemyAI
    update: (dt) =>
        for enemy in *@pool.groups.enemy.entities
            -- grab the player, also the difference vector to it
            player = @pool.groups.player.entities[1]
            diff = player.position - enemy.position
            
            -- break locking if need to aim
            if enemy.state=="locked"
                if math.abs(diff\angle!-enemy.angle)%360>enemy.turntreshold
                    enemy.state = "aim"
                    return

            -- if need to move
            if enemy.state=="aim" or enemy.state=="locked"
                if math.abs(diff\length!-enemy.movetarget)>enemy.movetreshold
                    enemy.state = "move"
                    return

            -- if need to turn
            if enemy.state=="move"
                -- too close or too away?
                if diff\length! < enemy.movetarget
                    -- need to turn away
                    if math.abs(diff\angle!-enemy.angle+180)%360>2*enemy.turntreshold
                        enemy.state = "turn"
                        enemy.velocity = Vec2(0,0)
                        return
                else
                    -- need to turn to the player
                    if math.abs(diff\angle!-enemy.angle)%360>2*enemy.turntreshold
                        enemy.state = "turn"
                        enemy.velocity = Vec2(0,0)
                        return
            
            -- aim logic
            if enemy.state=="aim"
                -- finished aiming
                if math.abs(enemy.angle - diff\angle!)<10^-2
                    enemy.state = "locked"
                    return
                else
                    -- move it towards the player
                    enemy.angle += sign((enemy.angle-diff\angle!)%360 - 180) * enemy.turnrate * dt
                    
                    -- 'crop' angle value into [-180; 180] interval
                    -- TODO: refactor this into a function or something
                    if enemy.angle>180
                        enemy.angle -= 360
                    if enemy.angle<-180
                        enemy.angle += 360
                    return 

            -- move logic
            if enemy.state=="move"
                -- finished moving
                if math.abs(diff\length!-enemy.movetarget)<1
                    enemy.state="aim"
                    enemy.velocity = Vec2(0, 0)
                    return
                else
                    enemy.velocity = Vec2.fromAngle(enemy.angle, enemy.movespeed)
            
            -- turn logic
            if enemy.state=="turn"
                turn_to = 0
                if diff\length! < enemy.movetarget
                    turn_to = diff\angle! + 180
                else
                    turn_to = diff\angle!
                turn_to = crop_angle turn_to

                -- finished turning
                if math.abs(enemy.angle - turn_to)<enemy.turntreshold
                    enemy.state = "move"
                    return
                else
                    -- move it towards the player
                    enemy.angle += sign((enemy.angle-turn_to)%360 - 180) * enemy.turnrate * dt
                    
                    -- 'crop' angle value into [-180; 180] interval
                    -- TODO: refactor this into a function or something
                    enemy.angle = crop_angle enemy.angle
                    return 