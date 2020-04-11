
rgb = (r, g, b, a=255) ->
    {r/255, g/255, b/255, a/255}

class BulletDrawer
    draw: =>
        love.graphics.setColor {153/255, 0/255, 0/255}
        for e in *@pool.groups.bullet.entities
            if e.type=="Bullet"
                love.graphics.circle "fill", e.position.x, e.position.y, 10
        love.graphics.setColor rgb(0, 153, 255, 128)
        for e in *@pool.groups.bullet.entities
            if e.type=="ExplodingBullet"
                love.graphics.circle "fill", e.position.x, e.position.y, 14
        love.graphics.setColor rgb(0, 0, 255)
        for e in *@pool.groups.bullet.entities
            if e.type=="ExplodingBullet"
                love.graphics.circle "fill", e.position.x, e.position.y, 10
         
            
