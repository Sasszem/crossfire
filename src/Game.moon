nata = require "lib.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"
Camera = require "src.entity.camera.Camera"

class Game
    new: (w, h) =>
        @w = w
        @h = h
        @pool = nata.new NataConfig
        @player = Player!
        @player.state = "Shield"
        @pool\queue @player
        @camera = Camera!
        @pool\queue @camera
        @pool\flush!
    update: (dt) =>
        @pool\emit "update", dt
    draw: () =>
        love.graphics.push!
        love.graphics.translate -@camera.position.x + @w/2, -@camera.position.y + @h/2
        @pool\emit "draw"
        love.graphics.pop!