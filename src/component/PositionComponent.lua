local Vec2 = require("src.Vec2")

local function PositionComponent(position)
    return {
        position = position or Vec2()
    }
end

return PositionComponent