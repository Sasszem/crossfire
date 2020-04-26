
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
        player.collision_radius = 25
    end
    player.powerupCancel = 30    
    powerup.despawnTimer = 0
end

function Powerup:revertPowerup(player)
    player.state = "Normal"
    player.powerupCancel = -1
    player.collision_radius = 40
end

function Powerup:update(dt)
    for i, e in ipairs(self.pool.groups.player.entities) do
        if e.powerupCancel <= 0 and e.powerupCancel ~= -1 then
            self:revertPowerup(e)
        end

        if e.powerupCancel > 0 then
            e.powerupCancel = e.powerupCancel - dt
        end
    end
end

return Powerup
