Player = require "src.entity.player.Player"
GhostPlayer = require "src.entity.player.GhostPlayer"
Vec2 = require "src.Vec2"

describe "GhostPlayer", ->
    ghostPlayer = GhostPlayer!

    it "should be created", ->
        assert.truthy ghostPlayer
    it "should inherit from Player", ->
        assert.equals Player, GhostPlayer.__class.__parent