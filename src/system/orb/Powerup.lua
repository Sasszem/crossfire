
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
        return
    end

    if player.state ~= "Normal" then
        self:revertPowerup(player)
    end

    player.state = powerup.state

    if player.state == "Buster" then
        player.collisionRadius = 25
    end
    player.powerupCancel = 30
    flux.to(player, 30, {powerupCancel = 0}):ease("linear"):oncomplete(self:revertPowerup(player))
    powerup.despawnTimer = 0
end

function Powerup:revertPowerup(player)
    return function()
        player.state = "Normal"
        player.powerupCancel = -1
        player.collisionRadius = 40
    end
end

return Powerup
