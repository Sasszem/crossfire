require("builder.utils")

local function Clean()
    run_command("rm game.love", true)
    run_command("rm src/AllSystems.lua", true)
    run_command("rm src/Components.lua", true)
end

return Clean