require("src.utils")

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Explosion = (position, parent) ->
    buildEntity "Explosion",
        C.PositionComponent position,
        C.CollisionComponent 0,
        C.DespawnComponent 1,
        {
            age: 0
            seen: {}
            :parent
        },
        {
            update: (dt) =>
                @age += dt
                @collision_radius = 100*@age
            draw: =>
                love.graphics.setColor(rgb(255, 76, 76, 128-64*@age))
                love.graphics.setLineWidth 3
                love.graphics.circle "line", @position.x, @position.y, @collision_radius
        }

return Explosion
