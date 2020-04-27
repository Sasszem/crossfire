require("builder.utils")

function Lint()
    run_command("luacheck .")
end

return Lint