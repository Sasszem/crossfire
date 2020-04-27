require("builder.utils")

local function Lint()
    run_command("luacheck .")
end

return Lint