nata = require "lib.nata.nata"
NataConfig = require "src.NataConfig"
Player = require "src.entity.player.Player"

Playfield = require "src.Playfield"
HUD = require "src.HUD"
config = require "src.config"

DEBUG = true
LOG = false

local installEventLogger
local ShockWave
local Enemy
local BigEnemy
local Vec2

if DEBUG
    if LOG
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

        @config = config

        -- shared game values & objects
        @score = 0
        @player = Player!


        -- Nata Config
        config = NataConfig
        config.data = @
        table.insert(config.systems, 1, nata.oop!)

        -- Nata Pool
        @pool = nata.new config
        if LOG
            installEventLogger(@pool)
        @pool\queue @player
        @pool\flush!

        @playfield = Playfield\new(@)
        @hud = HUD\new(@)

        @paused = false
        @debugDraw = false

        @slowdown = false
        @slowdownFactor = 1
        @slowdownTime = 5
        @slowdownFlag = false

    update: (dt, force = false) =>
        -- enter slowdown
        if love.mouse.isDown(1, 2, 3) and not @slowdown and @slowdownTime > 1 and not @slowdownFlag
            @slowdown = true
        -- quit slowdown
        if @slowdown and (not love.mouse.isDown(1, 2, 3) or @slowdownTime<=0)
            @slowdown = false
            if @slowdownTime<=0
                @slowdownFlag = true

        if @slowdown
            @slowdownFactor = math.max(0.3, @slowdownFactor - dt*1.5)
            @slowdownTime = @slowdownTime - dt
        else
            @slowdownFactor = math.min(1, @slowdownFactor + dt*2.5)
            @slowdownTime = math.min(@slowdownTime + dt, 5)
        
        dt = dt * @slowdownFactor
        
        if not @paused or force
            @pool\emit "update", dt
        @pool\flush!


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

        if DEBUG and (key=="1" or key=="2" or key=="x") 
            x, y = love.mouse.getPosition()
            sx, sy = @\screenToWorld(x, y)
            if key=="1"
                @pool\queue(Enemy(Vec2(sx, sy)))
            if key=="2"
                @pool\queue(BigEnemy(Vec2(sx, sy)))
            if key=="x"
                m = Vec2(sx, sy)
                for e in *@pool.groups.collision.entities
                    if (e.position-m)\length! <= e.collision_radius
                        if e!=@player
                            e.despawnTimer = 0
                        if @pool.groups.enemy.hasEntity[e]
                            e.despawnTimer = 0.2
    mousepressed: ( x, y, button, istouch, presses ) =>
        return
    mousereleased: (x, y, button, istouch, presses) =>
        @slowdownFlag = false    

return Game