nata = require "lib.nata.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"

Playfield = require "src.Playfield"
HUD = require "src.HUD"

DEBUG = true

local installEventLogger
local ShockWave
local Enemy
local BigEnemy
local Vec2

if DEBUG
    import installEventLogger from require "src.EventLogger"
    ShockWave = require "src.entity.player.ShockWave"
    Enemy = require "src.entity.enemy.Enemy"
    BigEnemy = require "src.entity.enemy.BigEnemy"
    Vec2 = require "src.Vec2"


class Game
    new: (w, h) =>
        -- screen dimensions
        @w = w
        @h = h

        -- shared game values & objects
        @score = 0
        @player = Player!


        -- Nata Config
        config = NataConfig
        config.data = @
        table.insert(config.systems, 1, nata.oop!)

        -- Nata Pool
        @pool = nata.new config
        if DEBUG
            installEventLogger(@pool)
        @pool\queue @player
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
        love.graphics.translate -@player.position.x + @w/2, -@player.position.y + @h/2
        
        @playfield\draw!
        @pool\emit "draw"
        if @debugDraw
            @pool\emit "debugDraw"
        love.graphics.pop!
        @hud\draw!
        if @debugDraw
            @hud\debugDraw!

    screenToWorld: (x, y) =>
        return x-@w/2+@player.position.x, y-@h/2+@player.position.y

    keypressed: (key, rep) =>
        if key=="return" and not rep and DEBUG
            @paused = not @paused
        if key=="space" and @paused
            self\update(0.001, true)
        if key=="s" and @paused
            for i=1, 100
                self\update(0.001, true)
        if key=="d" and not rep and DEBUG
            @debugDraw = not @debugDraw
        if key=="w" and DEBUG 
            @pool\queue ShockWave @player.position
    mousepressed: ( x, y, button, istouch, presses ) =>
        if not DEBUG
            return
        sx, sy = @\screenToWorld(x, y)
        if button==1
            @pool\queue(Enemy(Vec2(sx, sy)))
        if button==2
            @pool\queue(BigEnemy(Vec2(sx, sy)))
        if button==3
            m = Vec2(sx, sy)
            for e in *@pool.groups.collision.entities
                if (e.position-m)\length! <= e.collision_radius
                    if e!=@player
                        e.despawnTimer = 0

return Game