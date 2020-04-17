--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

require("src.utils")

Vec2 = require("src.Vec2")

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

colors =
    "Normal": rgb(51, 102, 255)
    "Buster": rgb(255, 204, 0)
    "Ghost":  rgb(204, 51, 153, 128)
    "Shield": rgb(102, 255, 51)

Player = (position, angle=0) ->
    buildEntity "Player",
        C.PositionComponent position,
        C.VelocityComponent!,
        C.CollisionComponent 40,
        C.DirectionComponent!,
        C.DespawnComponent!,
        C.TargetComponent!,
        C.LivesCounterComponent!,
        {
            state: "Normal"
            powerupCancel: -1
            hitCooldown: 0
            draw: =>
                love.graphics.setColor(colors[@state])
                love.graphics.circle("fill", @position.x, @position.y, 40)
                fromP = @position + Vec2.fromAngle(@angle, 39)
                toP = @position + Vec2.fromAngle(@angle, 60)
                love.graphics.setLineWidth(10)
                love.graphics.line(fromP.x, fromP.y, toP.x, toP.y)
                if @state=="Shield"
                    love.graphics.setColor(rgb(255, 0, 0))
                    love.graphics.circle("line", @position.x, @position.y, 40)
            update: (dt) =>
                if @hitCooldown > -1
                    @hitCooldown -= dt
        }


return Player