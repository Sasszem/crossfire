nata = require "lib.nata"
NataConfig = require "src.NataConfig"
EnemyShoot = require "src.system.enemy.EnemyShoot"
Enemy = require "src.entity.enemy.Enemy"
Vec2 = require "src.Vec2"


describe "EnemyShoot", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {EnemyShoot}
    }

    entity = Enemy Vec2!

    pool\queue entity
    pool\flush!

    angle = 30 * math.random 12
    entity.aim = angle

    -- get instance
    instance = pool\getSystem EnemyShoot

    it "should be imported", ->
        assert.truthy EnemyShoot

    it "should be createable", ->
        assert.truthy EnemyShoot!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update cooldowns", ->
        pool\emit "update", 1

        assert.equals entity.refire_rate - 1, entity.shoot_cooldown

    it "should create a bullet", ->

        pool\emit "update", entity.refire_rate
        assert.equals 1, #pool.groups.bullet.entities
        
    