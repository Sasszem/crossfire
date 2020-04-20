--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

Vec2 = require("src.Vec2")

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"


Orb = (position) ->
    buildEntity "Orb",
        C.PositionComponent(position),
        C.CollisionComponent(7),
        C.DespawnComponent(math.random(10, 20)),
        {
            draw: =>
                love.graphics.setColor(rgb(255, 255, 255))
                love.graphics.circle "fill", @position.x, @position.y, 5
                love.graphics.setColor(rgb(255, 255, 255, 128))
                love.graphics.circle "fill", @position.x, @position.y, 7
            update: (dt) =>
                @position += Vec2(math.random!-0.5, math.random!-0.5)*50*dt
        }
return Orb
