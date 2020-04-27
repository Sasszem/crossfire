require("builder.utils")

local function Package()
    run_command("love-release -W 64")
end

return Package