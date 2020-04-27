std = "min"

exclude_files = {
    "lib",
}

files["src"] = {
    ignore = {"212", "213"},
    globals = {
        "love",
        "unpack",
        "math",
        
        -- utils.lua functions
        "rgb",
        "cropAngle",
        "sign",
        "fade",
    }
}
files["main.lua"] = files["src"]
files["conf.lua"] = files["src"]

files["builder"] = {
    globals = {
        "run_command",
        "capture_command",
        "magiclines",
        "endswith",
        "append_path"
    }
}