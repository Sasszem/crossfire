--- Aim enemies to the Player
-- @classmod src.system.enemy.EnemyAim

class EnemyAim
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        player = @pool.data.player
        for entity in *@pool.groups.enemy.entities
            with entity
                .aim = (player.position - .position)\angle!