--- System to translate @{src.entity.bullet.Bullet}-@{src.entity.enemy.Enemy} and
-- @{src.entity.bullet.Bullet}-@{src.entity.player.Player} collision events
-- (but ignore @{src.entity.bullet.ExplodingBullet}s) to hit events
-- @classmod src.system.bullet.BulletCollisionResolver

local BulletCollisionResolver = {}

--- collision event handler
-- @param first the first entity
-- @param second the second entity
function BulletCollisionResolver:collision(bullet, victim)
    if bullet.type ~= "Bullet" then
        return
    end

    if not self.pool.groups.target.hasEntity[victim] then
        return
    end

    -- ignore if it's the enemy's own bullet
    if bullet.parent == victim then
        return
    end

    -- ignore shield and ghost player - bullet collisions
    if self.pool.groups.player.hasEntity[victim] and ( victim.state == "Shield" or victim.state=="Ghost" ) then
        return
    end

    bullet.despawnTimer = 0
    self.pool:emit("hit", victim)
end

return BulletCollisionResolver
