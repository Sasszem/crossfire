require("builder.utils")

local function InstallDev()
    print("NOTE: Luarocks 3+ is required!")
    print("NOTE: libzip is required!")
    print()
    local user = capture_command("whoami")
    if user~="root\n" then
        print("This command must be run as root!")
        print("Please retry with sudo!")
        print("")
        os.exit(-1)
    end
    print("Tryng to install dev dependencies...")
    run_command("luarocks install --server=http://luarocks.org/dev love-release")
    run_command("luarocks install luacheck")
    print("All dev dependencies should be installed")
end

return InstallDev