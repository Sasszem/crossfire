require("lib.yalg")
require("src.utils")

local ButtonStyle = {
    placement = "fill",
    padding = 10,
    font = Font(30, "asset/supercomputer.ttf"),
    borderColor = RED,
    activeBorder = GREEN,
}

function ButtonStyle:mouseEnter(x, y)
    -- set active border, backup current
    self.style.borderColor, self.style.activeBorder = self.style.activeBorder, self.style.borderColor
    sounds:effect("menu")
end

function ButtonStyle:mouseLeave(x, y)
    -- swap borders back
    self.style.borderColor, self.style.activeBorder = self.style.activeBorder, self.style.borderColor
end


-- switch a switcher and maybe reset the game on click
-- also do unpause game and highscore reloading
-- gets commands via the ID
-- anything!state|switcherID|resetGame
-- state is the state switch the ID to
-- a special value "~" is used to switch to the last state (ie back)
-- switcherID is the ID of the switcher to switch
-- (defaults to "switcher")
-- if resetGame is present (do not care about the value), reset the game
function ButtonStyle:click(x, y, button)

    -- ignore non-commands
    local optionsString = self.id:match("!(.+)")
    if not optionsString then return end

    --print("Found options string: "..optionsString)

    -- get options
    local optionsProvided = {}
    for o in optionsString:gmatch("[^|]+") do
        optionsProvided[#optionsProvided+1] = o
    end
    local state = optionsProvided[1]
    local switcher = optionsProvided[2] or "switcher"
    local resetgame = optionsProvided[3]
    local switcherWidget = self:getWidget(switcher)

    -- return to last
    if state == "~" then
        state = switcherWidget.lastSelected
    end

    -- do selection change
    switcherWidget.lastSelected = switcherWidget.selected
    switcherWidget.selected = state

    -- reset game
    if resetgame then
        self:getWidget("game"):initGame()
    end

    -- unpause game
    if state == "game" then
        self:getWidget("game").game:unpause()
    end

    -- reload highscores
    if state == "highscores" then
        self:getWidget("highscores"):loadHighscores()
    end
end

return ButtonStyle