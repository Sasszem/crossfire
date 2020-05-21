require("builder.utils")

local Build = require("builder.task.Build")

local function Package()
    Build()
    run_command("love-release -W 64")
end

return Package