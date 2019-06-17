class Vec2
    new: (x=0, y=0) =>
        @x = x
        @y = y
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
    normalize: =>
        len = @\length!
        assert len>0
        Vec2 @x/len, @y/len
    
    fromAngle: (angle, len=1) ->
        angle = math.rad angle
        Vec2(math.cos(angle), math.sin(angle)) * len

    angle: =>
        math.deg math.atan2(@y, @x)
