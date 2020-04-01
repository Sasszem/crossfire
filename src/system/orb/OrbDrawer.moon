class OrbDrawer
    draw: =>
        love.graphics.setColor {1,1,1}
        for orb in *@pool.groups.orb.entities
            love.graphics.circle "fill", orb.position.x, orb.position.y, 5
        love.graphics.setColor {1,1,1,0.5}
        for orb in *@pool.groups.orb.entities
            love.graphics.circle "fill", orb.position.x, orb.position.y, 7
