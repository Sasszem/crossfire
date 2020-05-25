require("lib.yalg")
local ButtonStyle = require("src.menu.ButtonStyle")

local PauseMenu = VDiv(
    Button("Continue", ButtonStyle, "pause!game"),
    Button("Highscores", ButtonStyle, "pause!highscores"),
    Button("Options", ButtonStyle, "pause!options"),
    Button("Main menu", ButtonStyle, "pause!mainMenu"),
    {
        width = 250,
        placement = "center",
        gap = 10
    },
    "pause"
)

function PauseMenu:draw()
    self:getWidget("game"):draw()
    VDiv.draw(self)
end

return PauseMenu