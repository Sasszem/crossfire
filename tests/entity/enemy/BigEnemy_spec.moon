BigEnemy = require "src.entity.enemy.BigEnemy"
Vec2 = require "src.Vec2"

describe "BigEnemy", ->
    bigEnemy = BigEnemy!

    it "should be created", ->
        assert.truthy bigEnemy
    it "should have a position", ->
        assert.truthy bigEnemy.position
        assert.equals bigEnemy.position.__class, Vec2
    it "should have a velocity", ->
        assert.truthy bigEnemy.velocity
        assert.equals bigEnemy.velocity.__class, Vec2
    it "should have a direction", ->
        assert.truthy bigEnemy.aim
        assert.is_number bigEnemy.aim
    it "should have a speed", ->
        assert.truthy bigEnemy.speed
        assert.is_number bigEnemy.speed
    it "should have a turnspeed", ->
        assert.truthy bigEnemy.turnspeed
        assert.is_number bigEnemy.turnspeed
    