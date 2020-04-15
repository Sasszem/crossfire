require "src.utils"

Vec2 = require "src.Vec2"

Enemy = require "src.entity.enemy.Enemy"
BigEnemy = require "src.entity.enemy.BigEnemy"

-- TODO: Refactor this
e = Enemy!
eMt = e.movetarget
eT = e.movetreshold
b = BigEnemy!
bMt = b.movetarget
bT = b.movetreshold


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
            --should_have_bigEnemy = math.floor @pool.data.score / 50
            should_have_bigEnemy = 1

            player = @pool.groups.player.entities[1]
            ofset = Vec2.fromAngle(math.random(360), math.random(100, 150))

            if @bigEnemyCount < should_have_bigEnemy
                bE = BigEnemy player.position+ofset
                @pool\queue bE
                @cooldown = @period
                @pool\emit "spawn", bE
                @bigEnemyCount += 1
                
                return
            if @enemyCount < should_have_enemy
                e = Enemy player.position + ofset
                @pool\queue e
                @cooldown = @period
                @pool\emit "spawn", e
                @enemyCount += 1
                return

    EnemyDeath: (pos, type) =>
        if type=="Enemy"
            @enemyCount -= 1
        if type=="BigEnemy"
            @bigEnemyCount -= 1

    -- debug draw
    debugDraw: =>

        -- move target circles
        p = @pool.groups.player.entities[1]
        love.graphics.setLineWidth 2
        love.graphics.setColor(rgb(255, 255, 255))
        love.graphics.circle "line", p.position.x, p.position.y, eMt-eT
        love.graphics.circle "line", p.position.x, p.position.y, eMt+eT
        love.graphics.setColor(rgb(0, 255, 0))
        love.graphics.circle "line", p.position.x, p.position.y, bMt-bT
        love.graphics.circle "line", p.position.x, p.position.y, bMt+bT

        
        -- enemy states
        love.graphics.setColor(rgb(255, 255, 255))
        for en in *@pool.groups.enemy.entities
            love.graphics.print en.state, en.position.x, en.position.y
        
        -- TODO: Refactor this into a member function to avoid code duplication!
        should_have_enemy = math.floor(@pool.data.score / 10) + 1
        should_have_bigEnemy = math.floor @pool.data.score / 50
        
        -- counts and should-haves
        love.graphics.push!
        love.graphics.origin!
        love.graphics.print "Should have E: #{should_have_enemy}", 10, 30
        love.graphics.print "Should have bE: #{should_have_bigEnemy}", 10, 50
        love.graphics.print "Has E: #{@enemyCount}", 10, 70
        love.graphics.print "Has bE: #{@bigEnemyCount}", 10, 90
        love.graphics.pop!
