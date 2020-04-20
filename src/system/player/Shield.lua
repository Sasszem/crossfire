local Vec2 = require("src.Vec2")

local Shield = {}

function Shield:collision(bullet, player)
    -- filter for Bullets and Players
    if not self.pool.groups.bullet.hasEntity[bullet] then
        return
    end

    if not self.pool.groups.player.hasEntity[player] then
        return
    end

    -- filter for shield players
    if player.state~="Shield" then
        return
    end

    -- turn Bullet back
    bullet.velocity = Vec2.fromAngle((bullet.position-player.position):angle(), bullet.velocity:length())

    -- remove their parent
    bullet.parent = nil
end

return Shield