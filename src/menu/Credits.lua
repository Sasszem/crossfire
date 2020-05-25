require("lib.yalg")

local Vec2 = require("src.Vec2")

local BS = require("src.menu.ButtonStyle")
local LS = require("src.menu.LabelStyle")


local Credits = VDiv(
    HDiv(
        Label("Game by", LS), 
        Label("Sasszem", LS, "SML"), 
        {placement = "center", gap = 10}
    ),
    Label("Uses the Löve2D engine", LS),
    Label("DigitFont by David Chung", 
        {font = Font(30, "asset/DigitFont.ttf")}
    ),
    Label("Supercomputer font by Disaster Fonts", LS),
    VDiv(
        Label("Sounds from orangefreesounds.com", LS),
        Label("(edited them a bit with audacity)", {font = Font(20, "asset/supercomputer.ttf")})
    ),
    Label("Original game idea by Seetoh Wei Tung", LS),
    Label(""),
    HDiv(
        Button("Back", BS, "credits!~"),
        {
            slots = 5
        }
    ),
    {
        slots = 7
    },
    "credits"
)

-- Do a cool lil effect on my name

local function getColor(t)
    -- lil color math
    -- kinda like HSL but simpler
    local v = Vec2.fromAngle(t*270)

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

local t = 0

function Credits:update(dt)
    t = t + dt
    self:getWidget("SML").style.textColor = getColor(t)
end

return Credits