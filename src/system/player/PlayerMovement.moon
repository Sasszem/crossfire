Vec2 = require "src.Vec2"

class PlayerMovement
    init: =>
        @w = @pool.data.w
        @h = @pool.data.h
    update: (dt) =>
        mx, my = love.mouse.getPosition!
        angle = (Vec2 mx-@w/2, my-@h/2)\angle!
        for p in *@pool.groups.player.entities
            v = 40
            if p.state == "Buster"
                v = 60
            p.velocity = Vec2.fromAngle(angle, v)
            p.angle = angle
