local PackageTask = require("builder.task.Package")
local CleanTask = require("builder.task.Clean")
local LaunchTask = require("builder.task.Launch")
local LintTask = require("builder.task.Lint")
local InstallDev = require("builder.task.InstallDev")

local Runner = {
    package = PackageTask,
    clean = CleanTask,
    launch = LaunchTask,
    lint = LintTask,
    ["install-dev"] = InstallDev
}

local command = arg[1] or "(no command provided)"
if not Runner[command] then
    print("Error: invalud command: "..command)
    print("Valid commands include:")
    for k, _ in pairs(Runner) do
        print("   "..k)
    end
else
    Runner[command]()
end