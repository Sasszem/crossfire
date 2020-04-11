Orb = require "src.entity.orb.Orb"
Vec2 = require "src.Vec2"

class OrbSpawner
    EnemyDeath: (pos, type) =>
        num = 1
        if type=="Enemy"
            num = math.random 8
        else
            num = math.random 15
        for i=1,num
            angle = math.random 360
            len = math.random 10
            ofset = Vec2.fromAngle angle, len
            @pool\queue Orb(pos + ofset)
