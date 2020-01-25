Vec2 = require "src.Vec2"

VelocityComponent = {}

VelocityComponent.new = (velocity = Vec2(0,1), speed = 10) ->
    {
        :velocity
        :speed
    }

VelocityComponent.fromPolar = (angle=0, size=1, speed = size) ->
    {
        velocity: Vec2.fromAngle(angle, size)
        :speed
    }

setmetatable VelocityComponent, {__call: (velocity) => VelocityComponent.new velocity}

return VelocityComponent