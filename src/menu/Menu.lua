require("lib.yalg")

-- main menu system
-- handles & forwards input events too


local MainMenu = require("src.menu.MainMenu")
local GameWrapper = require("src.menu.GameWrapper")
local OptionsMenu = require("src.menu.OptionsMenu")
local Credits = require("src.menu.Credits")
local PauseMenu = require("src.menu.PauseMenu")
local Highscores = require("src.menu.Highscores")
local EnterHighscore = require("src.menu.EnterHighscore")

local Menu = GUI(
    Switcher(
        GameWrapper(),
        OptionsMenu,
        Credits,
        PauseMenu,
        Highscores,
        EnterHighscore,
        MainMenu,
        "switcher"
    )
)

function Menu:init()
    -- set basic LÖVE settings
    love.window.setTitle("Crossfire")
    love.window.setIcon(love.image.newImageData("asset/icon.png"))
    love.keyboard.setKeyRepeat(false)
    love.keyboard.setTextInput(false)
end

-- forward events glue-logic

function Menu:mousepressed(x, y, button, isTouch, presses)
    if self:getWidget("switcher").selected == "game" then
        self:getWidget("game").game:mousepressed(x, y, button, isTouch, presses)
    end
    self:handleClick(x, y, button)
end

function Menu:mousereleased(x, y, button, isTouch, presses)
    if self:getWidget("switcher").selected == "game" then
        self:getWidget("game").game:mousereleased(x, y, button, isTouch, presses)
    end
end

function Menu:update(dt)
    GUI.update(self)
    self:getWidget("credits"):update(dt)
    self:getWidget("enterHighscore"):update(dt)
    if self:getWidget("switcher").selected == "game" then
        self:getWidget("game").game:update(dt)
    end
end

function Menu:keypressed(key, code, rep)
    -- pause game on escape
    if self:getWidget("switcher").selected == "game" then
        self:getWidget("game").game:keypressed(key, rep)
        if key=="escape" then
            self:getWidget("switcher").selected = "pause"
        end
        return
    end
    -- continue paused game on escape
    if self:getWidget("switcher").selected == "pause" then
        if key=="escape" then
            self:getWidget("pause!game").style.click(self:getWidget("pause!game"))
        end
        return
    end
    -- save highscore on return
    if self:getWidget("switcher").selected == "enterHighscore" then
        if key=="return" then
            self:getWidget("enterHighscore"):save()
        end
        return
    end
    -- return to prev. menu on escape
    if key=="escape" then
        self:getWidget("switcher").selected = (self:getWidget("switcher").lastSelected or "mainMenu")
    end
end

function Menu:textinput(text)
    self:getWidget("enterHighscore"):textinput(text)
end

return Menu