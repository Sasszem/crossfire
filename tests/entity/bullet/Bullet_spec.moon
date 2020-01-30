Bullet = require "src.entity.bullet.Bullet"
Vec2 = require "src.Vec2"

describe "Bullet", ->
    bullet = Bullet!

    it "should be created", ->
        assert.truthy bullet
    it "should have a position", ->
        assert.truthy bullet.position
        assert.equals bullet.position.__class, Vec2
    it "should have a velocity", ->
        assert.truthy bullet.velocity
        assert.equals bullet.velocity.__class, Vec2
    it "should be a bullet", ->
        assert.truthy bullet.isBullet
    
    