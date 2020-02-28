Vec2 = require "src.Vec2"

class PlayerDrawer
    draw: () =>
        colors =
            "Normal": {51/255, 102/255, 255/255}
            "Buster": {255/255, 204/255, 0/255}
            "Ghost": {204/255, 51/255, 153/255}
            "Shield": {102/255, 255/255, 51/255}

        for player in *@pool.groups.player.entities
            love.graphics.setColor colors[player.state]
            love.graphics.circle "fill", player.position.x, player.position.y, 50
            v = Vec2.fromAngle player.angle, 100
            love.graphics.setLineWidth 10
            love.graphics.line player.position.x, player.position.y, player.position.x + v.x, player.position.y + v.y
            if player.state=="Shield"
                love.graphics.setColor({1, 0, 0})
                love.graphics.arc "line", "open", player.position.x, player.position.y, 100, player.angle - 0.79, player.angle + 0.79 

            
