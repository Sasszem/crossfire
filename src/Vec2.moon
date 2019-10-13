--- A simple 2D vector class for computations
--- @classmod src.Vec2
class Vec2
    --- Create and return a new Vec2
    -- @tparam number x the X component of the vector
    -- @tparam number y the Y component of the vector
    -- @treturn Vec2 the new instance
    new: (x=0, y=0) =>
        @x = x
        @y = y

    --- Compute the length of the vector
    -- @treturn int the length of the vector
    length: =>
        math.sqrt(@x^2 + @y^2)
    
    __add: (other) =>
        Vec2(other.x + @x, other.y + @y)
    __sub: (other) =>
        Vec2(@x - other.x, @y - other.y)
    __mul: (other) =>
        if type(other) == "number"
            Vec2(other * @x, other * @y)
        else
            other.x * @x + other.y * @y
    
    --- Normalize the vector
    -- @treturn number Vec2 a new vector with the same direction with length 1
    normalize: =>
        len = @\length!
        assert len>0
        Vec2 @x/len, @y/len
    
    --- Create a new vector from an angle and length
    -- @tparam number angle the angle
    -- @tparam number len length of the vector, defaults to 1
    -- @treturn Vec2 A new vector with given angle and length
    fromAngle: (angle, len=1) ->
        angle = math.rad angle
        Vec2(math.cos(angle), math.sin(angle)) * len


    --- Compute the angle of the vector
    -- @treturn number the angle of the vector
    angle: =>
        math.deg math.atan2(@y, @x)
