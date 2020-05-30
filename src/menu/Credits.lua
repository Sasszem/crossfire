require("lib.yalg")
require("src.colorEffect")
require("src.utils")

local BS = require("src.menu.ButtonStyle")
local LS = require("src.menu.LabelStyle")


local Credits = VDiv(
    HDiv(
        Label("Game by", LS),
        Label("Sasszem", LS, "SML"),
        Label("(2020)", LS),
        {placement = "center", gap = 10}
    ),
    Label("Uses the Löve2D engine", LS),
    Label("DigitFont by David Chung",
        {font = Font(30, "asset/DigitFont.ttf")}
    ),
    Label("Supercomputer font by Disaster Fonts", LS),
    VDiv(
        Label("Sounds and music from orangefreesounds.com", LS),
        Label("(edited them a bit with audacity)", {font = Font(20, "asset/supercomputer.ttf")}),
        Label("(see github repo for full list)", {font = Font(20, "asset/supercomputer.ttf")})
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

function Credits:update()
    self:getWidget("SML").style.textColor = getColor(getTime()*270)
end

return Credits