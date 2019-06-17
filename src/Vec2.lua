local Vec2
do
  local _class_0
  local _base_0 = {
    length = function(self)
      return math.sqrt(self.x ^ 2 + self.y ^ 2)
    end,
    __add = function(self, other)
      return Vec2(other.x + self.x, other.y + self.y)
    end,
    __sub = function(self, other)
      return Vec2(self.x - other.x, self.y - other.y)
    end,
    __mul = function(self, other)
      if type(other) == "number" then
        return Vec2(other * self.x, other * self.y)
      else
        return other.x * self.x + other.y * self.y
      end
    end,
    normalize = function(self)
      local len = self:length()
      assert(len > 0)
      return Vec2(self.x / len, self.y / len)
    end,
    fromAngle = function(angle, len)
      if len == nil then
        len = 1
      end
      angle = math.rad(angle)
      return Vec2(math.cos(angle), math.sin(angle)) * len
    end,
    angle = function(self)
      return math.atan(self.y / self.x) / math.pi * 180
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      self.x = x
      self.y = y
    end,
    __base = _base_0,
    __name = "Vec2"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Vec2 = _class_0
  return _class_0
end
