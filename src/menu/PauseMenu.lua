require("lib.yalg")
local ButtonStyle = require("src.menu.ButtonStyle")

local PauseMenu = GUI(
    Button("Continue", ButtonStyle, "escape"),
    Button("Highscores", ButtonStyle, "h"),
    Button("Options", ButtonStyle, "o"),
    Button("Main menu", ButtonStyle, "q"),
    {
        width = 250,
        placement = "center",
        gap = 10
    }
)

return PauseMenu