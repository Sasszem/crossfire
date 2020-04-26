--- The Player moves trough the field avoiding @{src.entity.bullet.Bullet}s and collecting @{src.entity.orb.Orb}s
-- @classmod src.entity.player.Player

require("src.utils")

Vec2 = require("src.Vec2")

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

colors =
    "Normal": rgb(51, 102, 255)
    "Buster": rgb(128, 0, 0)
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
            drawLayer: 5
            draw: =>
                fadeFactor = math.min((5 - @hitCooldown)/4, 1)
                if fadeFactor < 0.2
                    fadeFactor = 0
                love.graphics.setColor(fade(colors[@state], fadeFactor))
                love.graphics.setLineWidth(1)
                love.graphics.circle("fill", @position.x, @position.y, @collision_radius)
                love.graphics.circle("line", @position.x, @position.y, @collision_radius)
                where = @position + Vec2.fromAngle(@angle, @collision_radius - 10)
                love.graphics.setColor(fade(rgb(0,0,0), fadeFactor))
                love.graphics.circle("fill", where.x, where.y, 5)
                love.graphics.circle("line", where.x, where.y, 5)
                if @state=="Shield"
                    love.graphics.setColor(fade(rgb(255, 0, 0), fadeFactor))
                    love.graphics.setLineWidth(3)
                    love.graphics.circle("line", @position.x, @position.y, @collision_radius)
            update: (dt) =>
                if @hitCooldown > -1
                    @hitCooldown -= dt
        }


return Player