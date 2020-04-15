require "src.utils"
Vec2 = require "src.Vec2"

class PlayerDrawer
    draw: () =>
        colors =
            "Normal": rgb(51, 102, 255)
            "Buster": rgb(255, 204, 0)
            "Ghost":  rgb(204, 51, 153)
            "Shield": rgb(102, 255, 51)

        for player in *@pool.groups.player.entities
            love.graphics.setColor colors[player.state]
            love.graphics.circle "fill", player.position.x, player.position.y, 50
            v = Vec2.fromAngle player.angle, 100
            love.graphics.setLineWidth 10
            love.graphics.line player.position.x, player.position.y, player.position.x + v.x, player.position.y + v.y
            if player.state=="Shield"
                love.graphics.setColor(rgb(255, 0, 0))
                love.graphics.circle "line", player.position.x, player.position.y, 50
