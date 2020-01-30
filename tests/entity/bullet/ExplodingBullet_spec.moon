ExplodingBullet = require "src.entity.bullet.ExplodingBullet"
Vec2 = require "src.Vec2"

describe "ExplodingBullet", ->
    explodingBullet = ExplodingBullet!

    it "should be created", ->
        assert.truthy explodingBullet
    it "should have a position", ->
        assert.truthy explodingBullet.position
        assert.equals explodingBullet.position.__class, Vec2
    it "should have a velocity", ->
        assert.truthy explodingBullet.velocity
        assert.equals explodingBullet.velocity.__class, Vec2
    it "should explode", ->
        assert.truthy explodingBullet.explosion_radius
    
    