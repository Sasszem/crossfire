Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

describe "Player", ->
    player = Player!

    it "should be created", ->
        assert.truthy player
    it "should have a position", ->
        assert.truthy player.position
        assert.equals player.position.__class, Vec2
    it "should have a velocity", ->
        assert.truthy player.velocity
        assert.equals player.velocity.__class, Vec2
    it "should have a direction", ->
        assert.truthy player.angle
        assert.is_number player.angle
    it "should have some lives", ->
        assert.truthy player.lives
        assert.is_number player.lives
    it "should be a target", ->
        assert.truthy player.isTarget
    
    