nata = require "lib.nata"
NataConfig = require "src.NataConfig"
EnemyMovement = require "src.system.enemy.EnemyMovement"
Enemy = require "src.entity.enemy.Enemy"
Vec2 = require "src.Vec2"

describe "EnemyMovement", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {EnemyMovement}
    }

    entity = Enemy Vec2!

    pool\queue entity
    pool\flush!

    angle = 30 * math.random 12
    entity.angle = angle

    -- get instance
    instance = pool\getSystem EnemyMovement

    it "should be imported", ->
        assert.truthy EnemyMovement

    it "should be createable", ->
        assert.truthy EnemyMovement!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update the entities velocity", ->

        pool\emit "update", 1
        
        velocity = Vec2.fromAngle(angle, entity.speed)

        assert.same velocity, entity.velocity
        
    