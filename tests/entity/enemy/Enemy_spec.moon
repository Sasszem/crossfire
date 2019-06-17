Enemy = require "src.entity.enemy.Enemy"
Vec2 = require "src.Vec2"

describe "Enemy", ->
    enemy = Enemy!

    it "should be created", ->
        assert.truthy enemy
    it "should have a position", ->
        assert.truthy enemy.position
        assert.equals enemy.position.__class, Vec2
    it "should have a velocity", ->
        assert.truthy enemy.velocity
        assert.equals enemy.velocity.__class, Vec2
    it "should have a direction", ->
        assert.truthy enemy.aim
        assert.is_number enemy.aim
    it "should have a speed", ->
        assert.truthy enemy.speed
        assert.is_number enemy.speed
    it "should have a turnspeed", ->
        assert.truthy enemy.turnspeed
        assert.is_number enemy.turnspeed
    