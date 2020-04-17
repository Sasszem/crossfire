Vec2 = require "src.Vec2"

class PlayerMovement
    init: =>
        @w = @pool.data.w
        @h = @pool.data.h
    update: (dt) =>
        mx, my = love.mouse.getPosition!
        angle = (Vec2 mx-@w/2, my-@h/2)\angle!
        for p in *@pool.groups.player.entities
            p.velocity = Vec2.fromAngle(angle, 40)
            p.angle = angle
