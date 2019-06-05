Camera = require "src.entity.camera.Camera"
Vec2 = require "src.Vec2"

describe "Camera", ->
    camera = Camera!

    it "should be created", ->
        assert.truthy camera
    it "should have a position", ->
        assert.truthy camera.position
        assert.equals camera.position.__class, Vec2
    