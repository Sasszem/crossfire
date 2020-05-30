require("lib.yalg")

local LS = require("src.menu.LabelStyle")
local BS = require("src.menu.ButtonStyle")

local yesBtn = Button("Yes", BS, "soq!mainMenu")
local noBtn = Button("No", BS, "soq!~")

yesBtn.style.backgroundColor = GREEN
yesBtn.style.borderColor = rgb(255, 255, 255)
yesBtn.style.activeBorder = BLUE
noBtn.style.backgroundColor = RED
noBtn.style.borderColor = rgb(255, 255, 255)
noBtn.style.activeBorder = BLUE
function yesBtn.style:click(button, x, y)
    self:getWidget("game"):endGame()
end

local SaveOrQuit = VDiv(
    Label("Are you sure that you want to quit?", LS),
    HDiv(
        yesBtn,
        Label("", {span = 3}),
        noBtn
    ),
    {
        placement = "center"
    },
    "saveOrQuit"
)

function SaveOrQuit:draw()
    self:getWidget("game"):draw()
    VDiv.draw(self)
end

return SaveOrQuit