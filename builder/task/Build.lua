local GCI = require("builder.task.ComponentImports")
local GSI = require("builder.task.SystemImports")
local Clean = require("builder.task.Clean")

local function Build()
    Clean()
    GCI()
    GSI()
end

return Build