require("src.utils")
local Explosion = require "src.entity.bullet.Explosion"

local ExplosionSpawner = {}

function ExplosionSpawner:collision(bullet, victim)
    if not self.pool.groups.target.hasEntity[victim] then
        return
    end

    if bullet.type ~= "ExplodingBullet" then
        return
    end

    if victim.state == "Ghost" then
        return
    end

    -- kill bullet
    bullet.despawnTimer = 0

    if victim.state ~= "Buster" and victim.state ~= "Shield" then
        -- hit that victim
        self.pool:emit("hit", victim)
    end

    self.pool:queue(Explosion(bullet.position, bullet.parent))
    sounds:effect("explosion")
end

return ExplosionSpawner