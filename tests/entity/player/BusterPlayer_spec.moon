Player = require "src.entity.player.Player"
BusterPlayer = require "src.entity.player.BusterPlayer"
Vec2 = require "src.Vec2"

describe "BusterPlayer", ->
    busterPlayer = BusterPlayer!

    it "should be created", ->
        assert.truthy busterPlayer
    it "should have twice the speed of the original", ->
        assert.equals Player!.speed*2, busterPlayer.speed
    it "should inherit from Player", ->
        assert.equals Player, BusterPlayer.__class.__parent