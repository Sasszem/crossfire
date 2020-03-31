Vec2 = require "src.Vec2"

class Shield
    collision: (bullet, player) =>
        -- filter for Bullets and Players
        if not @pool.groups.bullet.hasEntity[bullet]
            return
        if not @pool.groups.player.hasEntity[player]
            return

        -- filter for shield players
        if player.state!="Shield"
            return

        -- turn Bullet back
        bullet.velocity = Vec2.fromAngle((bullet.position-player.position)\angle!, bullet.velocity\length!)

        -- remove their parent
        bullet.parent = nil

        
