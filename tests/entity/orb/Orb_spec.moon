Orb = require "src.entity.orb.Orb"
Vec2 = require "src.Vec2"

describe "Orb", ->
    orb = Orb!

    it "should be created", ->
        assert.truthy orb
    it "should have a position", ->
        assert.truthy orb.position
        assert.equals orb.position.__class, Vec2
    
    