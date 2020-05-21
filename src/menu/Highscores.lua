require("lib.yalg")

local Highscores = require("src.Highscores")

local BS = require("src.menu.ButtonStyle")
local LS = require("src.menu.LabelStyle")

-- some styles
local rowStyle = {
    margin = 20,
}
local inactiveStyle = {
    border = 0,
    borderColor = rgb(0, 0, 0, 0)
}
local activeStyle = {
    border = 2,
    borderColor = rgb(255, 0, 0)
}

-- line generator
local function line(i)
    return HDiv(
        Label("", LS, "score"..tostring(i)),
        Label("", LS, "name"..tostring(i)),
        rowStyle,
        "row"..tostring(i)
    )
end

-- style updater function
local function setStyle(r, style)
    for k, v in pairs(style) do
        r.style[k] = v
    end
end


local ButtonMenu = HDiv(
    Button("Back", BS, "escape"),
    Label("", {span = 2}),
    Button("Erase highscores", BS, "eraseBtn"),
    "buttonMenu"
)


local ConfirmMenu = HDiv(
    Button("Yes", BS, "yesBtn"),
    Label(""),
    Label(""),
    Label(""),
    Button("No", BS, "noBtn"),
    "confirmMenu"
)

local HighscoresMenu = GUI(
    VDiv(
        line(1),
        line(2),
        line(3),
        line(4),
        line(5),
        Switcher(ButtonMenu, ConfirmMenu, {}, "switcher"),
        {
            gap = 10,
        }
    )
)

-- set some styles, overriding default ones
HighscoresMenu.widgets.yesBtn.style.backgroundColor = rgb(0, 255, 0)
HighscoresMenu.widgets.yesBtn.style.borderColor = rgb(255, 255, 255)
HighscoresMenu.widgets.yesBtn.style.activeBorder = rgb(255, 255, 0)
HighscoresMenu.widgets.noBtn.style.backgroundColor = rgb(255, 0, 0)
HighscoresMenu.widgets.noBtn.style.borderColor = rgb(255, 255, 255)
HighscoresMenu.widgets.noBtn.style.activeBorder = rgb(255, 255, 0)
HighscoresMenu.widgets.eraseBtn.style.span = 2

-- recalculate because we changed geometry by setting span
HighscoresMenu:recalculate()


-- event handlers
function HighscoresMenu.widgets.yesBtn.style:click(x, y, button)
    Highscores.delete()
    HighscoresMenu:loadHighscores()
    HighscoresMenu:getWidget("switcher").selected = "buttonMenu"
end

function HighscoresMenu.widgets.noBtn.style:click(x, y, button)
    HighscoresMenu:getWidget("switcher").selected = "buttonMenu"
end

function HighscoresMenu.widgets.eraseBtn.style:click(x, y, button)
    HighscoresMenu:getWidget("switcher").selected = "confirmMenu"
end

-- loader function
function HighscoresMenu:loadHighscores()
    for i = 1, 5 do
        self:getWidget("score"..tostring(i)).text = ""
        self:getWidget("name"..tostring(i)).text = ""
        setStyle(self:getWidget("row"..tostring(i)), inactiveStyle)
    end

    local scores = Highscores.load()
    for i = 1, 5 do
        if i>#scores then return end
        self:getWidget("score"..tostring(i)).text = tostring(scores[i][1])
        self:getWidget("name"..tostring(i)).text = scores[i][2]
        setStyle(self:getWidget("row"..tostring(i)), activeStyle)
    end
end

return HighscoresMenu