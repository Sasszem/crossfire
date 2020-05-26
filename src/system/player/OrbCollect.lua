require("src.utils")
local OrbCollect = {}

function OrbCollect:collision(orb, player)
    if not self.pool.groups.orb.hasEntity[orb] then
        return
    end

    if not self.pool.groups.player.hasEntity[player] then
        return
    end

    orb.despawnTimer = 0
    self.pool.data.score = self.pool.data.score + 5
    sounds:effect("pickup")
end

return OrbCollect