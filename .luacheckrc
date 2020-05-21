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
        
        -- utils.lua functions and values
        "rgb",
        "cropAngle",
        "sign",
        "fade",
        "flux",

        -- GUI stuff from YALG
        "rgb",
        "Font",
        "GUI",
        "VDiv",
        "HDiv",
        "Button",
        "Label",
        "Switcher",
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