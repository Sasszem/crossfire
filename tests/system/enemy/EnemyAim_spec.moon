nata = require "lib.nata"
NataConfig = require "src.NataConfig"
EnemyAim = require "src.system.enemy.EnemyAim"
Enemy = require "src.entity.enemy.Enemy"
Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"


describe "EnemyAim", ->
    -- setup environment

    entity = Enemy Vec2!
    player = Player Vec2!

    pool = nata.new {
        groups: NataConfig.groups
        systems: {EnemyAim}
        data:
            :player
    }

    pool\queue entity
    pool\queue player
    pool\flush!

    angle = 30 * math.random 12
    entity.aim = angle

    -- get instance
    instance = pool\getSystem EnemyAim

    it "should be imported", ->
        assert.truthy EnemyAim

    it "should be createable", ->
        assert.truthy EnemyAim!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update the entities aim", ->

        pool\emit "update", 1
        assert.near entity.aim, (player.position - entity.position)\angle!, 10^-6
        
    