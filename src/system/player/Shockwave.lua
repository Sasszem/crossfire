local Shockwave = {}

function Shockwave:collision(wave, victim)
    -- only care about shockwave-collisions
    if wave.type~="ShockWave" then
        return
    end

    -- only care about despawnable entities
    if not self.pool.groups.despawn.hasEntity[victim] then
        return
    end

    -- do not kill players
    if self.pool.groups.player.hasEntity[victim] then
        return
    end

    -- hit entity
    self.pool:emit("hit", victim)

    -- despawn Bullets
    if self.pool.groups.bullet.hasEntity[victim] then
        victim.despawnTimer = 0
    end
end

return Shockwave