require "src.utils"

Vec2 = require "src.Vec2"

class EnemyAI
    update: (dt) =>
        player = @pool.groups.player.entities[1]
        for enemy in *@pool.groups.enemy.entities
            -- grab the player, also the difference vector to it
            diff = player.position - enemy.position
            
            -- break locking if need to aim
            if enemy.state=="locked"
                if math.abs(diff\angle!-enemy.angle)>enemy.turntreshold
                    enemy.state = "aim"
                    continue

            -- if need to move
            if enemy.state=="aim" or enemy.state=="locked"
                if math.abs(diff\length!-enemy.movetarget)>enemy.movetreshold
                    enemy.state = "move"
                    continue

            -- if need to turn
            if enemy.state=="move"
                -- too close or too away?
                if diff\length! < enemy.movetarget
                    -- need to turn away
                    if math.abs(cropAngle(diff\angle!+180)-enemy.angle)>2*enemy.turntreshold
                        enemy.state = "turn"
                        enemy.velocity = Vec2(0,0)
                        continue
                else
                    -- need to turn to the player
                    if math.abs(diff\angle!-enemy.angle)>2*enemy.turntreshold
                        enemy.state = "turn"
                        enemy.velocity = Vec2(0,0)
                        continue
            
            -- aim logic
            if enemy.state=="aim"
                -- finished aiming
                if math.abs(enemy.angle - diff\angle!)<1
                    enemy.state = "locked"
                    continue
                else
                    -- aim towards the player
                    enemy.angle += sign(diff\angle! - enemy.angle) * enemy.turnrate * dt
                    enemy.angle = cropAngle(enemy.angle)

            -- move logic
            if enemy.state=="move"
                -- finished moving
                if math.abs(diff\length!-enemy.movetarget)<1
                    enemy.state="aim"
                    enemy.velocity = Vec2(0, 0)
                    continue
                else
                    enemy.velocity = Vec2.fromAngle(enemy.angle, enemy.movespeed)
            
            -- turn logic
            if enemy.state=="turn"
                turn_to = 0
                if diff\length! < enemy.movetarget
                    turn_to = diff\angle! + 180
                else
                    turn_to = diff\angle!
                turn_to = cropAngle(turn_to)

                -- finished turning
                if math.abs(enemy.angle - turn_to)<enemy.turntreshold
                    enemy.state = "move"
                    continue
                else
                    -- turn it towards the target
                    enemy.angle += sign(turn_to - enemy.angle) * enemy.turnrate * dt
                    enemy.angle = cropAngle(enemy.angle)
                    continue 