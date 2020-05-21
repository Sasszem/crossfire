require("lib.yalg")
local ButtonStyle = {
    placement = "fill",
    padding = 10,
    font = Font(30, "asset/supercomputer.ttf"),
    activeBorder = rgb(0, 255, 0),
}

function ButtonStyle:mouseEnter(x, y)
    -- set active border, backup current
    self.style.borderColor, self.style.activeBorder = self.style.activeBorder, self.style.borderColor
    -- TODO: add sound!
end

function ButtonStyle:mouseLeave(x, y)
    -- swap borders back
    self.style.borderColor, self.style.activeBorder = self.style.activeBorder, self.style.borderColor
end

function ButtonStyle:click(x, y, button)
    local key = self.id
    love.event.push("keypressed", key, key, false)
end

return ButtonStyle