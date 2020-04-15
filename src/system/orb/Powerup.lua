
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

    player.state = powerup.state
    player.powerupCancel = 15    
    powerup.despawnTimer = 0
end

function Powerup:update(dt)
    for i, e in ipairs(self.pool.groups.player.entities) do
        if e.powerupCancel <= 0 and e.powerupCancel ~= -1 then
            e.state = "Normal"
            e.powerupCancel = -1
            print("Reverted powerup state")
        end

        if e.powerupCancel > 0 then
            e.powerupCancel = e.powerupCancel - dt
        end
    end
end

return Powerup
