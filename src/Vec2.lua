--- A simple 2D vector class for computations
--- @classmod src.Vec2

require("src.utils")

local Vec2 = {}
Vec2.__index = Vec2

--- Create and return a new Vec2
-- @tparam number x the X component of the vector
-- @tparam number y the Y component of the vector
-- @treturn Vec2 the new instance
function Vec2:new(x, y)
    local o = {
        x = x or 0,
        y = y or 0,
    }
    setmetatable(o, Vec2)
    return o
end

Vec2.__call = Vec2.new

--- Compute the length of the vector
-- @treturn int the length of the vector
function Vec2:length()
    return math.sqrt(self.x^2 + self.y^2)
end


function Vec2:__add(other)
    return Vec2(other.x + self.x, other.y + self.y)
end


function Vec2:__sub(other)
    return Vec2(self.x - other.x, self.y - other.y)
end


function Vec2:__mul(other)
    if type(other) == "number" then
        return Vec2(other * self.x, other * self.y)
    end
    return other.x * self.x + other.y * self.y
end


--- Normalize the vector
-- @treturn number Vec2 a new vector with the same direction with length 1
function Vec2:normalize()
    local len = self:length()
    assert(len>0)
    return Vec2(self.x/len, self.y/len)
end
    

--- Create a new vector from an angle and length
-- @tparam number angle the angle
-- @tparam number len length of the vector, defaults to 1
-- @treturn Vec2 A new vector with given angle and length
function Vec2.fromAngle(angle, len)
    len = len or 1
    angle = math.rad(angle)
    return Vec2(math.cos(angle), math.sin(angle)) * len
end


--- Compute the angle of the vector
-- @treturn number the angle of the vector
function Vec2:angle()
    return cropAngle(math.deg(math.atan2(self.y, self.x)))
end

setmetatable(Vec2, Vec2)

return Vec2