nata = require "lib.nata.nata"
NataConfig = require "src.NataConfig"
EnemyHit = require "src.system.enemy.EnemyHit"
Enemy = require "src.entity.enemy.Enemy"

DummyEntity = () ->
    {}

describe "EnemyHit", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {EnemyHit}
    }

    entity = Enemy!

    pool\queue entity
    pool\queue DummyEntity!
    pool\flush!

    enemyDeathSpy = spy.new (pos) ->
    pool\on "EnemyDeath", enemyDeathSpy

    pool\emit "hit", entity


    -- get instance
    instance = pool\getSystem EnemyHit

    it "should be imported", ->
        assert.truthy EnemyHit

    it "should be createable", ->
        assert.truthy EnemyHit!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have a 'hit' listener", ->
        assert.is_function instance.hit

    it "should update the entities despawnTimer", ->
        assert.equals 0, entity.despawnTimer
    
    it "should emit an EnemyDeath event", ->
        assert.spy(enemyDeathSpy).was.called(1)
        assert.spy(enemyDeathSpy).was.called_with(entity.position, entity.type)
        
    
