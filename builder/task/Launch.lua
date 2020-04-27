require("builder.utils")

local Build = require("builder.task.Build")
local Clean = require("builder.task.Clean")

function Launch()
    Build()
    run_command("love .")
end

return Launch