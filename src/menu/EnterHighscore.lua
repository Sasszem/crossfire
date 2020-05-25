require("lib.yalg")

local LS = require("src.menu.LabelStyle")
local Highscores = require("src.Highscores")

local rowStyle = {
    margin = 20,
    border = 2,
    borderColor = rgb(255, 0, 0)
}

local EnterHighscore = GUI(
    Label("New Highscore", LS, "hsLbl"),
    Label("", {span = 2}),
    Label("Enter your name:", LS),
    HDiv(
        Label("", LS, "scoreLbl"),
        Label("", LS, "nameLbl"),
        rowStyle
    ),
    "enterHighscore"
)

-- copy my effect from credits
local Vec2 = require("src.Vec2")

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

local oldUpdate = EnterHighscore.update
function EnterHighscore:update(dt)
    t = t + dt
    oldUpdate(self)
    self:getWidget("hsLbl").style.textColor = getColor(t)
end

local utf8 = require("utf8")

function EnterHighscore:keypressed(key, code, rep)
    if key=="backspace" then
        local text = self:getWidget("nameLbl").text
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            text = string.sub(text, 1, byteoffset - 1)
        end
        self:getWidget("nameLbl").text = text
    end
end


function EnterHighscore:textinput(tx)
    self:getWidget("nameLbl").text = self:getWidget("nameLbl").text..tx
end

function EnterHighscore:save()
    print("Saving those highscores...")
    Highscores.update(self:getWidget("game").game.score, self:getWidget("nameLbl").text)
    love.keyboard.setTextInput(false)
    self:getWidget("switcher").selected = "highscores"
    self:getWidget("switcher").lastSelected = "mainMenu"
    self:getWidget("highscores"):loadHighscores()
end

return EnterHighscore