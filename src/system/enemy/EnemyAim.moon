class EnemyMovement
    update: (dt) =>
        player = @pool.groups.player.entities[1]
        for entity in *@pool.groups.enemy.entities
            with entity
                .aim = (player.position - .position)\angle!