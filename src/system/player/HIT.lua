local ShockWave = require "src.entity.player.ShockWave"

local PlayerHit = {}

function PlayerHit:hit(player)
    -- filter for player hits
    if not self.pool.groups.player.hasEntity[player] then
        return
    end

    -- ignore Ghost and buster states
    if player.state=="Ghost" or player.state=="Buster" then
        return
    end

    -- cooldown
    if player.hitCooldown > 0 then
        return
    end

    -- set cooldown
    player.hitCooldown = 5

    player.lives = player.lives - 1

    if player.lives == 0 then
        self.pool:emit("GameOver")
    end

    self.pool:queue(ShockWave(player.position))
end


return PlayerHit