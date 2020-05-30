require("lib.yalg")
local ButtonStyle = require("src.menu.ButtonStyle")

local MainMenu = VDiv(
    Label(""), -- placeholder label for title text
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

function MainMenu:drawTitle()
    local titleText = "CROSSFIRE"
    local textTable = {}
    local angle = getTime()*(-270)
    local i = 0
    for char in titleText:gmatch("%w") do -- each letter
        textTable[#textTable+1] = getColor(angle + 20*i)
        textTable[#textTable+1] = char
        i = i + 1
    end
    love.graphics.setColor(rgb(200, 200, 200))
    local w, h = love.graphics.getDimensions()
    love.graphics.printf(textTable, Font(100, "asset/DigitFont.ttf"), 0, 50, w, "center")
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
    self:drawTitle()
end

return MainMenu