Player = require "src.entity.player.Player"
GhostPlayer = require "src.entity.player.GhostPlayer"

describe "GhostPlayer", ->
    ghostPlayer = GhostPlayer!

    it "should be created", ->
        assert.truthy ghostPlayer
    it "should inherit from Player", ->
        assert.equals Player, GhostPlayer.__class.__parent