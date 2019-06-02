nata = require "lib.nata"
NataConfig = require "src.NataConfig"
VelocitySystem = require "src.system.VelocitySystem"
Vec2 = require "src.Vec2"

describe "VelocitySystem", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {VelocitySystem}
    }

    entity =
        position: Vec2!
        velocity: Vec2 math.random(-10, 10), math.random(-10,10)

    pool\queue entity
    pool\flush!

    -- get instance
    instance = pool\getSystem VelocitySystem

    it "should be imported", ->
        assert.truthy VelocitySystem

    it "should be createable", ->
        assert.truthy VelocitySystem!

    it "should be added to the pool", ->
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update the entities position", ->
        dt = math.random 10

        pool\emit "update", dt
        
        expected = 
            x: entity.velocity.x * dt
            y: entity.velocity.y * dt
        actual = 
            x: entity.position.x
            y: entity.position.y
        
        assert.same expected, actual
        
    