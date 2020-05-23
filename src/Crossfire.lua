local MM = require("src.menu.MainMenu")
local Game = require("src.Game")
local PM = require("src.menu.PauseMenu")
local CR = require("src.menu.Credits")
local HM = require("src.menu.Highscores")
local NH = require("src.menu.EnterHighscore")
local OM = require("src.menu.OptionsMenu")

local Highscores = require("src.Highscores")

--[[
    A state machine, switching between:
    - Main menu - menu
    - Game - game
    - pause menu - pause
    - highscores menu - highscores
    - credits - credits
    - new highscore enter - newHighscore
    - options menu - options
    (second column is internal state id)
    (Might add options menu later)

    Keyboard, mouse and draw events are only forwarded to the current menu / game
    Switching is done by pushing keyboard events, so keyboard is an alternative control

    Main menu:
    - SPACE to start game -> starts a new game
    - H for highscores
    - C for credits
    - O for options
    - ESC to quit

    Game:
    - ESC to pause menu
    - Q to menu OR new highscore

    Pause menu:
    - ESC to game
    - Q to main menu
    - H to highscores
    - O for options

    Highscores
    - ESC to return to previous (pause or main menu)

    Credits:
    - ESC for main menu

    New highscore:
    - RETURN to menu

    Options:
    - ESC to return to previous
]]


local CrossfireGame = {
    state = "menu",
    lastState = "menu"
}
CrossfireGame.__index = CrossfireGame

function CrossfireGame:new()
    local w, h = love.graphics.getDimensions()

    local g = {}
    g.mainMenu = MM
    g.pauseMenu = PM
    g.credits = CR
    g.highscores = HM
    g.newHighscore = NH
    g.options = OM
    g.w = w
    g.h = h
    setmetatable(g, CrossfireGame)
    return g
end

function CrossfireGame:init()
    love.window.setTitle("Crossfire")
    love.window.setIcon(love.image.newImageData("asset/icon.png"))
    love.keyboard.setKeyRepeat(false)
    love.keyboard.setTextInput(false)
end

function CrossfireGame:update(dt)
    if self.state == "menu" then
        self.mainMenu:update()
    elseif self.state == "game" then
        self.game:update(dt)
    elseif self.state == "pause" then
        self.pauseMenu:update()
    elseif self.state == "credits" then
        self.credits:update(dt)
    elseif self.state == "highscores" then
        self.highscores:update()
    elseif self.state == "newHighscore" then
        self.newHighscore:update(dt)
    elseif self.state == "options" then
        self.options:update()
    end
end

function CrossfireGame:draw()
    if self.state == "menu" then
        self.mainMenu:draw()
    elseif self.state == "game"then
        self.game:draw()
    elseif self.state == "pause" then
        self.game:draw()
        self.pauseMenu:draw()
    elseif self.state == "credits" then
        self.credits:draw()
    elseif self.state == "highscores" then
        self.highscores:draw()
    elseif self.state == "newHighscore" then
        self.newHighscore:draw()
    elseif self.state == "options" then
        if self.lastState ~= "menu" then
            self.game:draw()
        end
        self.options:draw(self.lastState=="menu")
    end
end

function CrossfireGame:mousepressed( x, y, button, istouch, presses )
    if self.state == "menu" then
        self.mainMenu:handleClick(x, y, button)
    elseif self.state == "game" then
        self.game:mousepressed(x, y, button, istouch, presses)
    elseif self.state == "pause" then
        self.pauseMenu:handleClick(x, y, button)
    elseif self.state == "credits" then
        self.credits:handleClick(x, y, button)
    elseif self.state == "highscores" then
        self.highscores:handleClick(x, y, button)
    elseif self.state == "newHighscore" then
        self.newHighscore:handleClick(x, y, button)
    elseif self.state == "options" then
        self.options:handleClick(x, y, button)
    end
end

function CrossfireGame:mousereleased( x, y, button, istouch, presses )
    if self.state=="game" then
        self.game:mousereleased( x, y, button, istouch, presses )
    end
end

function CrossfireGame:keypressed(key, code, rep)
    if self.state == "game" then
        -- return from game
        self.game:keypressed(key, rep)
        if key == "escape" then
            self.state = "pause"
        end
        if key== "q" then
            if Highscores.shouldUpdate(self.game.score) then
                self.state = "newHighscore"
                love.keyboard.setTextInput(true)
                self.newHighscore:getWidget("nameLbl").text = "" -- placeholder - no one shuld be named this
                self.newHighscore:getWidget("scoreLbl").text = tostring(self.game.score)
            else
                self.state = "highscores"
            end
        end
    elseif self.state == "menu" then
        -- main menu
        if key=="space" then
            self.game = nil
            self.game = Game(self.w, self.h, self.options.options)
            self.state = "game"
        end
        if key=="escape" then
            love.event.quit()
        end
        if key=="h" then
            self.lastState = self.state
            self.highscores:loadHighscores()
            self.state = "highscores"
        end
        if key=="c" then
            self.state = "credits"
        end
        if key=="o" then
            self.lastState = self.state
            self.state = "options"
        end
    elseif self.state == "highscores" then
        -- highscores
        if key=="escape" then
            self.state = self.lastState
        end

    elseif self.state == "pause" then
        -- pause menu
        if key=="h" then
            self.lastState = self.state
            self.highscores:loadHighscores()
            self.state = "highscores"
        end
        if key=="escape" then
            self.state = "game"
            self.game:unpause()
        end
        if key=="q" then
            self.state = "menu"
        end
        if key=="o" then
            self.lastState = self.state
            self.state = "options"
        end
    elseif self.state == "credits" then
        if key=="escape" then
            self.state = "menu"
        end
    elseif self.state == "newHighscore" then
        if key=="return" then
            self.lastState = "menu"
            self.state = "highscores"
            love.keyboard.setTextInput(false)
            Highscores.update(self.game.score, self.newHighscore:getWidget("nameLbl").text)
            self.highscores:loadHighscores()
        else
            self.newHighscore:keypressed(key, code, rep)
        end
    elseif self.state == "options" then
        if key=="escape" then
            self.state = self.lastState
        end
    end
end

function CrossfireGame:textinput(t)
    if self.state == "newHighscore" then
        self.newHighscore:textinput(t)
    end
end

setmetatable(CrossfireGame, {__call = CrossfireGame.new})
return CrossfireGame