require("lib.yalg")

local HS = {
    margin = 10,
    border = 2,
    borderColor = rgb(255, 255, 255)
}

local OBS = require("src.menu.ButtonStyle")

local BS = {}
for k, v in pairs(OBS) do
    BS[k] = v
end

BS.activeBorder = rgb(255, 255, 255)
BS.activeBackground = rgb(0, 255, 0)
BS.borderColor = rgb(128, 128, 128)
BS.activeText = "On"
BS.backgroundColor = rgb(255, 0, 0)
BS.margin = 5

function BS:click(x, y, button)
    self.style.backgroundColor, self.style.activeBackground = self.style.activeBackground, self.style.backgroundColor
    self.text, self.style.activeText = self.style.activeText, self.text
    self:getWidget("options").options[self.id] = (self.text == "On")
end


local OptionsMenu = VDiv(
    HDiv(
        Label("Sounds"), Button("Off", BS, "sounds"), HS
    ),
    HDiv(
        Label("Effects"), Button("Off", BS, "effects"), HS
    ),
    HDiv(
        Label("Music"), Button("Off", BS, "music"), HS
    ),
    HDiv(
        Label("Debug mode"), Button("Off", BS, "debug"), HS
    ),
    HDiv(
        Label("Logging"), Button("Off", BS, "log"), HS
    ),
    Label("", {span = 2}),
    HDiv(
        Button("Back", OBS, "options!~"),
        {
            slots = 5
        }
    ),
    "options"
)

OptionsMenu.options = {}

-- activate defaults
OptionsMenu:getWidget("sounds").style.click(OptionsMenu:getWidget("sounds"))
OptionsMenu:getWidget("effects").style.click(OptionsMenu:getWidget("effects"))
OptionsMenu:getWidget("music").style.click(OptionsMenu:getWidget("music"))

-- draw the playfield as a background
local PlayField = require("src.Playfield")
local PF = PlayField:new({config = require("src.config")})

local originalDraw = OptionsMenu.draw
function OptionsMenu:draw(background)
    if self:getWidget("switcher").lastSelected=="mainMenu" then
        love.graphics.translate(400, 300)
        PF:draw()
        love.graphics.origin()
    else
        self:getWidget("game"):draw()
    end
    originalDraw(self)
end

return OptionsMenu