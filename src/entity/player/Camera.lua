local buildEntity = require("src.entity.buildEntity")
local C = require("src.Components")

local Camera = {
    shakeTime = 0,
    phiX = 0,
    phiY = 0,
    ampX = 0,
    ampY = 0,
    omega = 0,
}
Camera.__index = Camera


function Camera:new(player)
    local ent = buildEntity("Camera",
        C.PositionComponent()
    )
    setmetatable(ent, Camera)
    ent.player = player
    return ent
end


function Camera:update(dt)
    -- copy values as we've modifying them
    self.position.x = self.player.position.x
    self.position.y = self.player.position.y
    local angle = 360 * self.omega * self.shakeTime
    self.position.x = self.position.x + self.ampX * math.sin(math.rad(angle + self.phiX)) * self.shakeTime
    self.position.y = self.position.y + self.ampY * math.sin(math.rad(angle + self.phiY)) * self.shakeTime
end

function Camera:add(entity)
    if entity.type == "Explosion" then
        self.shakeTime = 1
        self.phiX = math.random(0, 360)
        self.phiY = math.random(0, 360)
        self.ampX = math.random(10, 15) * (math.random(1,2) - 1.5) * 2
        self.ampY = math.random(10, 15) * (math.random(1,2) - 1.5) * 2
        self.omega = 3
        flux.to(self, self.shakeTime, {shakeTime = 0}):ease("linear")
    end
end

setmetatable(Camera, {__call = Camera.new})
return Camera
