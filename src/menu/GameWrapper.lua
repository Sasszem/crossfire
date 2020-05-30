require("lib.yalg")
require("src.utils")

local Game = require("src.Game")
local Highscore = require("src.Highscores")

local GameWrapper = Label:extend()

function GameWrapper:endgameCallback()
    return function()
        self:endGame()
    end
end

function GameWrapper:endGame()
    local score = self.game.score
    if Highscore.shouldUpdate(score) then
        self:getWidget("switcher").selected = "enterHighscore"
        self:getWidget("scoreLbl").text = tostring(self.game.score)
        love.keyboard.setTextInput(true)
        sounds:setBackgroundMusic("music3")
    else
        self:getWidget("switcher").selected = "highscores"
    end
    self:getWidget("switcher").lastSelected = "mainMenu"
    self:getWidget("highscores"):loadHighscores()
end

function GameWrapper:new()
    Label.new(self, "", {placement = "fill", border = 0, margin = 0}, "game")
end

function GameWrapper:initGame()
    self.game = Game(self.w, self.h, self:getWidget("options").options)
    self.game.pool:on("GameOver", self:endgameCallback())
end

function GameWrapper:draw()
    self.game:draw()
end

function GameWrapper:update(dt)
    self.game:update(dt)
end

return GameWrapper
