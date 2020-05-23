require("src.utils")

local nata = require("lib.nata.nata")
local NataConfig = require("src.NataConfig")
local Player = require("src.entity.player.Player")

local Playfield = require("src.Playfield")
local HUD = require("src.HUD")
local config = require("src.config")

local EventLogger  = require("src.EventLogger")
local ShockWave = require "src.entity.player.ShockWave"
local Enemy = require "src.entity.enemy.Enemy"
local BigEnemy = require "src.entity.enemy.BigEnemy"
local Vec2 = require "src.Vec2"

local Game = {
    config = config,
    score = 0,
    paused = false,
    debugDraw = false,

    slowdown = false,
    slowdownFactor = 1,
    slowdownTime = 5,
    slowdownFlag = false,

    unpauseCooldown = 0,
}

function Game:new(w, h, options)
    local o = {}
    setmetatable(o, Game)
    -- screen dimensions
    o.w = w
    o.h = h
    o.options = options

    -- shared game values & objects
    o.player = Player()

    -- nata config
    local nconfig = NataConfig
    nconfig.data = o

    -- nata pool creation
    o.pool = nata.new(nconfig)
    EventLogger.installEventLogger(o.pool)
    o.pool:queue(o.player)
    o.pool:flush()

    -- setup game end even forwarding
    o.pool:on("GameOver", function()
        love.event.push("keypressed", "q", "q", false)
    end)

    o.playfield = Playfield:new(o)
    o.hud = HUD:new(o)

    o.noSlowdownTweens = flux.group()
    o:unpause()
    return o
end

function Game:unpause()
    EventLogger.enabled = self.options.log
    self.unpauseCooldown = 0.1
    self.noSlowdownTweens:to(self, 0.1, {unpauseCooldown = 0})
end

function Game:update(dt, force)
    self.noSlowdownTweens:update(dt)
    self:calculateSlowdown(dt)

    dt = dt * self.slowdownFactor

    if not self.paused or force then
        self.pool:emit("update", dt)
        flux.update(dt)
    end
    self.pool:flush()
end

function Game:calculateSlowdown(dt)
    -- enter slowdown
    if love.mouse.isDown(1, 2, 3)
        and not self.slowdown
        and self.slowdownTime > 1
        and not self.slowdownFlag
        and self.unpauseCooldown==0
    then
        self:enterSlowdown()
    end

    -- quit slowdown
    if self.slowdown and (not love.mouse.isDown(1, 2, 3) or self.slowdownTime<=0) then
        self:leaveSlowdown()
        if self.slowdownTime<=0 then
            self.slowdownFlag = true
        end
    end
end

function Game:enterSlowdown()
    self.slowdown = true
    self.noSlowdownTweens:to(self, 0.5, {slowdownFactor=0.3})
    self.noSlowdownTweens:to(self, self.slowdownTime, {slowdownTime=0}):ease("linear")
end

function Game:leaveSlowdown()
    self.slowdown = false
    self.noSlowdownTweens:to(self, 0.5, {slowdownFactor=1})
    self.noSlowdownTweens:to(self, 5-self.slowdownTime, {slowdownTime=5}):ease("linear")
end

function Game:draw()
    love.graphics.push()
    love.graphics.translate(-self.player.position.x + self.w/2, -self.player.position.y + self.h/2)

    self.playfield:draw()

    self.pool:emit("draw")
    if self.debugDraw and self.options.debug then
        self.pool:emit "debugDraw"
    end

    love.graphics.pop()
    self.hud:draw()
    if self.debugDraw and self.options.debug then
        self.hud:debugDraw()
    end
end


function Game:screenToWorld(x, y)
    return x-self.w/2+self.player.position.x, y-self.h/2+self.player.position.y
end


function Game:keypressed(key, rep)
    local DEBUG = self.options.debug
    if key=="return" and not rep and DEBUG then
        self.paused = not self.paused
    end
    if key=="space" and self.paused then
        self:update(0.001, true)
    end
    if key=="s" and self.paused then
        for i = 1, 100 do
            self:update(0.001, true)
        end
    end
    if key=="d" and not rep and DEBUG then
        self.debugDraw = not self.debugDraw
    end
    if key=="w" and DEBUG  then
        self.pool:queue(ShockWave(self.player.position))
    end
    if DEBUG and (key=="1" or key=="2" or key=="x") then
        local x, y = love.mouse.getPosition()
        local sx, sy = self:screenToWorld(x, y)
        if key=="1" then
            self.pool:queue(Enemy(Vec2(sx, sy)))
        end
        if key=="2" then
            self.pool:queue(BigEnemy(Vec2(sx, sy)))
        end
        if key=="x" then
            local m = Vec2(sx, sy)
            for _, e in ipairs(self.pool.groups.collision.entities) do
                if (e.position-m):length() <= e.collisionRadius then
                    if e~=self.player then
                        e.despawnTimer = 0
                    end
                    if self.pool.groups.enemy.hasEntity[e] then
                        e.despawnTimer = 0.2
                    end
                end
            end
        end
    end
end


function Game:mousepressed(x, y, button, istouch, presses)
end

function Game:mousereleased(x, y, button, istouch, presses)
    self.slowdownFlag = false
end

Game.__index = Game
Game.__call = Game.new
setmetatable(Game, Game)

return Game