nata = require "lib.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"
Camera = require "src.entity.camera.Camera"

class Game
    new: =>
        @pool = nata.new NataConfig
        @pool\queue Player!
        @pool\queue Camera!
        @pool\flush!
    update: (dt) =>
        @pool\emit "update", dt
    draw: () =>
        @pool\emit "draw"