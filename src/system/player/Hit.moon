ShockWave = require "src.entity.player.ShockWave"

class PlayerHit
    hit: (player) =>
        -- filter for Player HIT events
        if not @pool.groups.player.hasEntity[player]
            return

        -- ignore ghost and buster types
        if player.state=="Ghost" or player.state=="Buster" 
            return

        player.lives -= 1
        
        if player.lives == 0
            @pool.emit "GameOver"


        -- spawn shockwave
        @pool\queue ShockWave player.position        
