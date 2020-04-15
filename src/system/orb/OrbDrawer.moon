require "src.utils"
class OrbDrawer
    draw: =>
        love.graphics.setColor(rgb(255, 255, 255))
        for orb in *@pool.groups.orb.entities
            love.graphics.circle "fill", orb.position.x, orb.position.y, 5
        love.graphics.setColor(rgb(255, 255, 255, 128))
        for orb in *@pool.groups.orb.entities
            love.graphics.circle "fill", orb.position.x, orb.position.y, 7
