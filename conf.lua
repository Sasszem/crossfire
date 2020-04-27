function love.conf(t)
    t.releases = {
        title = "Crossfire",
        author = "Sasszem",
        description = "A simple bullet-dodging game",
        homepage = "https://github.com/Sasszem/crossfire/",
        version = "0.95",
        excludeFileList = {
            "%.git/.",
            "%.vscode",
            "builder",
            "build%.lua",
            "lib/nata/test",
            "lib/nata/demo"
        },
      }
end