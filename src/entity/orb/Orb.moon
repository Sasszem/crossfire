--- Orbs are dropped by @{src.entity.enemy.Enemy}s and @{src.entity.enemy.BigEnemy}s and worth points if picked ub by the @{src.entity.player.Player}
-- @classmod src.entity.orb.Orb

Vec2 = require "src.Vec2"

class Orb
    new: ( pos = Vec2! )=>
        @position = pos
