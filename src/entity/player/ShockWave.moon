buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

ShockWave = (position) ->
    buildEntity "ShockWave",
        C.PositionComponent position,
        C.CollisionComponent 0,
        C.DespawnComponent 1,
        {
            age: 0
        },
        {
            update: (dt) =>
                @age += dt
                @collision_radius = 1000*@age
            draw: =>
                love.graphics.setColor { 1, 1, 1, 0.5}
                love.graphics.circle "line", @position.x, @position.y, @collision_radius
        }

return ShockWave
