require("builder.utils")

function Clean()
    run_command("rm game.love", true)
    run_command("rm src/AllSystems.lua")
    run_command("rm src/Components.lua")
end

return Clean