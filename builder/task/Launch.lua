require("builder.utils")

local Build = require("builder.task.Build")

local function Launch()
    Build()
    run_command("love .")
end

return Launch