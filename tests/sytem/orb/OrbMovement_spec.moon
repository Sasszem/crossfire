nata = require "lib.nata"
NataConfig = require "src.NataConfig"
OrbMovement = require "src.system.orb.OrbMovement"
Orb = require "src.entity.orb.Orb"
Vec2 = require "src.Vec2"
moon = require "moon"

describe "OrbMovement", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {OrbMovement}
    }

    entity = Orb Vec2!

    pool\queue entity
    pool\flush!

    -- get instance
    instance = pool\getSystem OrbMovement

    it "should be imported", ->
        assert.truthy OrbMovement

    it "should be createable", ->
        assert.truthy OrbMovement!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update the entities position", ->
        dt = math.random 10

        pool\emit "update", dt
        
        assert.not.equals 0, entity.position.x, entity.position.y
        
    