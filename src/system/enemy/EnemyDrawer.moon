require "src.utils"
Vec2 = require "src.Vec2"

class EnemyDrawer
    draw: () =>
        for enemy in *@pool.groups.enemy.entities
            love.graphics.setColor(rgb(255, 204, 0))
            love.graphics.circle "fill", enemy.position.x, enemy.position.y, 30
            v = Vec2.fromAngle enemy.angle, 50
            love.graphics.setLineWidth 10
            love.graphics.line enemy.position.x, enemy.position.y, enemy.position.x + v.x, enemy.position.y + v.y

            
