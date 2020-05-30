local Vec2 = require("src.Vec2")
function getColor(angle)
    -- lil color math
    -- kinda like HSL but simpler
    local v = Vec2.fromAngle(angle)

    -- color unit vectors
    local rV = Vec2.fromAngle(0)
    local gV = Vec2.fromAngle(120)
    local bV = Vec2.fromAngle(240)
    -- dot products
    local r = math.max(v*rV, 0)*255
    local g = math.max(v*gV, 0)*255
    local b = math.max(v*bV, 0)*255

    return rgb(r, g, b)
end