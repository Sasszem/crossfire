require("lib.yalg")
require("src.colorEffect")
require("src.utils")

local LS = require("src.menu.LabelStyle")
local Highscores = require("src.Highscores")

local rowStyle = {
    margin = 20,
    border = 2,
    borderColor = RED,
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

local oldUpdate = EnterHighscore.update
function EnterHighscore:update()
    oldUpdate(self)
    self:getWidget("hsLbl").style.textColor = getColor(getTime()*270)
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
    if tx == "|" then return end
    self:getWidget("nameLbl").text = self:getWidget("nameLbl").text..tx
end

function EnterHighscore:save()
    Highscores.update(self:getWidget("game").game.score, self:getWidget("nameLbl").text)
    love.keyboard.setTextInput(false)
    self:getWidget("nameLbl").text = ""
    self:getWidget("switcher").selected = "highscores"
    self:getWidget("switcher").lastSelected = "mainMenu"
    self:getWidget("highscores"):loadHighscores()
    sounds:setBackgroundMusic("music1")
end

return EnterHighscore