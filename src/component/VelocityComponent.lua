local Vec2 = require("src.Vec2")

local VelocityComponent = {}

function VelocityComponent:new(velocity, speed)
    return {
        velocity = velocity or Vec2(0, 1),
        speed = speed or 10,
    }
end

function VelocityComponent.fromPolar(angle, size, speed)
    return {
        velocity = Vec2.fromAngle(angle or 0, size or 1),
        speed = speed or size or 1
    }
end

VelocityComponent.__call = VelocityComponent.new
setmetatable(VelocityComponent, VelocityComponent)

return VelocityComponent