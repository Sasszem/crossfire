Enemy = require "src.entity.enemy.Enemy"
BigEnemy = require "src.entity.enemy.BigEnemy"

class EnemySpawner
    init: =>
        @enemyCount = 0
        @bigEnemyCount = 0
        @cooldown = 1
        @period = 2
    
    update: (dt) =>
        @cooldown -= dt
        if @cooldown<=0
            should_have_enemy = math.floor(@pool.data.score / 10) + 1
            should_have_bigEnemy = math.floor @pool.data.score / 50

            if @bigEnemyCount < should_have_bigEnemy
                bE = BigEnemy!
                @pool\queue bE
                @cooldown = @period
                @pool\emit "spawn", bE
                @bigEnemyCount += 1
                
                return
            if @enemyCount < should_have_enemy
                e = Enemy!
                @pool\queue e
                @cooldown = @period
                @pool\emit "spawn", e
                @enemyCount += 1
                return

    EnemyDeath: (en) =>
        @enemyCount -= 1
