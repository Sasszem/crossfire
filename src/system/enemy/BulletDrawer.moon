require "src.utils"

class BulletDrawer
    draw: =>
        love.graphics.setColor(rgb(153, 0, 0))
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
         
            
