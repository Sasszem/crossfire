nata = require "lib.nata.nata"
NataConfig = require "src.NataConfig"
Shoot = require "src.system.Shoot"
Enemy = require "src.entity.enemy.Enemy"
Vec2 = require "src.Vec2"


describe "Shoot", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {Shoot}
    }

    entity = Enemy Vec2!

    pool\queue entity
    pool\flush!

    angle = 30 * math.random 12
    entity.aim = angle

    -- get instance
    instance = pool\getSystem Shoot

    it "should be imported", ->
        assert.truthy Shoot

    it "should be createable", ->
        assert.truthy Shoot!

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
        
    
