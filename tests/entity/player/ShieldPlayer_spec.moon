Player = require "src.entity.player.Player"
ShieldPlayer = require "src.entity.player.ShieldPlayer"
Vec2 = require "src.Vec2"

describe "ShieldPlayer", ->
    shieldPlayer = ShieldPlayer!

    it "should be created", ->
        assert.truthy shieldPlayer
    it "should inherit from Player", ->
        assert.equals Player, ShieldPlayer.__class.__parent