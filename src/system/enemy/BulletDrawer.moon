class BulletDrawer
    draw: =>
        love.graphics.setColor {153/255, 0/255, 0/255}
        for e in *@pool.groups.bullet.entities
            love.graphics.circle "fill", e.position.x, e.position.y, 10
         
            
