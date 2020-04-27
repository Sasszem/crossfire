require("builder.utils")

function Package()
    run_command("love-release -W 64")
end

return Package