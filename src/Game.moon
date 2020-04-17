nata = require "lib.nata.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"
Camera = require "src.entity.camera.Camera"

Playfield = require "src.Playfield"
HUD = require "src.HUD"

import installEventLogger from require "src.EventLogger"

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
        table.insert(config.systems, 1, nata.oop!)

        -- Nata Pool
        @pool = nata.new config
        installEventLogger(@pool)
        @pool\queue @player
        @pool\queue @camera
        @pool\flush!

        @playfield = Playfield\new(@)
        @hud = HUD\new(@)

        @paused = false
        @debugDraw = false

    update: (dt, force = false) =>
        if not @paused or force
            @pool\emit "update", dt


    draw: () =>
        love.graphics.push!
        love.graphics.translate -@camera.position.x + @w/2, -@camera.position.y + @h/2
        
        @playfield\draw!
        @pool\emit "draw"
        if @debugDraw
            @pool\emit "debugDraw"
        love.graphics.pop!
        @hud\draw!
        if @debugDraw
            @hud\debugDraw!


    keypressed: (key, rep) =>
        if key=="return" and not rep
            @paused = not @paused
        if key=="space" and @paused
            self\update(0.001, true)
        if key=="s" and @paused
            for i=1, 100
                self\update(0.001, true)
        if key=="d" and not rep
            @debugDraw = not @debugDraw

return Game