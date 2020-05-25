require("lib.yalg")
local ButtonStyle = require("src.menu.ButtonStyle")

local MainMenu = VDiv(
    Button("Play", ButtonStyle, "main!game|switcher|y"),
    Button("Highscores", ButtonStyle, "main!highscores"),
    Button("Options", ButtonStyle, "main!options"),
    Button("Credits", ButtonStyle, "main!credits"),
    Button("Quit", ButtonStyle, "quitButton"),
    {
        width = 250,
        placement = "center",
        gap = 10
    },
    "mainMenu"
)

function MainMenu.widgets.quitButton.style:click()
    love.event.push("quit")
end

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