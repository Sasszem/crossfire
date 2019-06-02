nata = require "lib.nata"
NataConfig = require "src.NataConfig"
DespawnSystem = require "src.system.DespawnSystem"

describe "DespawnSystem", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {DespawnSystem}
    }

    entity =
        despawnTimer: 10

    pool\queue entity
    pool\flush!

    -- get instance
    instance = pool\getSystem DespawnSystem

    it "should be imported", ->
        assert.truthy DespawnSystem

    it "should be createable", ->
        assert.truthy DespawnSystem!

    it "should be added to the pool", ->
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    dt = math.random 5
    it "should update despawn timers", ->
        pool\emit "update", dt

        assert.equals 10-dt, entity.despawnTimer
    
    it "should remove despawned entities", ->
        removeSpy = spy.new (entity) -> 
        pool\on("remove", removeSpy)

        pool\emit "update", 10-dt
        print entity.despawnTimer
        --assert.equals 0, #pool.groups.despawn.entities
        assert.spy(removeSpy).was.called()
        assert.spy(removeSpy).was.called_with(entity)
    
    
    it "should ignore entities with -1 despawn time", ->
        entity.despawnTimer = -1
        pool\queue entity
        pool\flush!

        
        pool\emit "update", dt

        assert.equals -1, entity.despawnTimer

        removeSpy = spy.new (entity) -> 
        pool\on("remove", removeSpy)
        assert.spy(removeSpy).was.called(0)

        
        
    