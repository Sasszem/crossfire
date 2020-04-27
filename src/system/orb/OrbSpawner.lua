local Orb = require "src.entity.orb.Orb"
local Vec2 = require "src.Vec2"
local Powerup = require "src.entity.orb.Powerup"

local OrbSpawner = {}

function OrbSpawner:EnemyDeath(pos, type)
    local num
    if type=="Enemy" then
        num = math.random(8)
    else
        num = math.random(15)
    end

    for i=1,num do
        local angle = math.random(360)
        local len = math.random(10)
        local ofset = Vec2.fromAngle(angle, len)
        self.pool:queue(Orb(pos + ofset, self.pool.data.score))
    end
    if math.random(1,10)==1 then
        self.pool:queue(Powerup(pos, self.pool.data.score))
    end
end

return OrbSpawner