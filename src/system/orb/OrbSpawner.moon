Orb = require "src.entity.orb.Orb"
Vec2 = require "src.Vec2"

class OrbSpawner
    EnemyDeath: (pos) =>
        num = math.random 8
        for i=1,num
            angle = math.rad math.random 360
            len = math.random 30
            ofset = Vec2.fromAngle angle, len
            @pool\queue Orb(pos + ofset)
