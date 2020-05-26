require("src.utils")
local Powerup = {}

function Powerup:update(dt)

end

function Powerup:collision(player, powerup)
    if not self.pool.groups.player.hasEntity[player] then
        return
    end
    if powerup.type ~= "Powerup" then
        return
    end

    if powerup.state == "Life" then
        player.lives = player.lives + 1
        powerup.despawnTimer = 0
        sounds:effect("extraLife")
        return
    end


    self:revertPowerup(player)()

    player.state = powerup.state

    if player.state == "Buster" then
        player.collisionRadius = 25
    end

    if player.state == "Shield" then
        sounds:setLPF(true)
    end

    player.powerupCancel = 30
    player.tween = flux.to(player, 30, {powerupCancel = 0}):ease("linear"):oncomplete(self:revertPowerup(player))
    powerup.despawnTimer = 0
    sounds:effect("powerup")
end

function Powerup:revertPowerup(player)
    return function()
        if player.tween then
            player.tween:stop()
            player.tween = nil
        end
        if player.powerupCancel==0 then
            sounds:effect("powerupReverse")
        end
        player.state = "Normal"
        player.powerupCancel = -1
        player.collisionRadius = 40
        sounds:setLPF(false)
    end
end

return Powerup
