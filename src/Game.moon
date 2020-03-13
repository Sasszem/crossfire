nata = require "lib.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"
Camera = require "src.entity.camera.Camera"

class Game
    new: (w, h) =>
        -- screen dimensions
        @w = w
        @h = h

        -- shared game values & objects
        @score = 0
        @camera = Camera!
        @player = Player!
        @player.state = "Shield"


        -- Nata Config
        config = NataConfig
        config.data = @

        -- Nata Pool
        @pool = nata.new config
        @pool\queue @player
        @pool\queue @camera
        @pool\flush!


    update: (dt) =>
        @pool\emit "update", dt


    draw: () =>
        love.graphics.push!
        love.graphics.translate -@camera.position.x + @w/2, -@camera.position.y + @h/2
        @pool\emit "draw"
        love.graphics.pop!