require("lib.yalg")
local ButtonStyle = require("src.menu.ButtonStyle")

local MainMenu = GUI(
    Button("Play", ButtonStyle, "space"),
    Button("Highscores", ButtonStyle, "h"),
    Button("Options", ButtonStyle, "o"),
    Button("Credits", ButtonStyle, "c"),
    Button("Quit", ButtonStyle, "escape"),
    {
        width = 250,
        placement = "center",
        gap = 10
    }
)

-- draw the playfield as a background
local PlayField = require("src.Playfield")
local PF = PlayField:new({config = require("src.config")})

local originalDraw = MainMenu.draw
function MainMenu:draw()
    love.graphics.translate(400, 300)
    PF:draw()
    love.graphics.origin()
    originalDraw(self)
end

return MainMenu