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
        assert.equals bigEnemy.aim.__class, Vec2
    
    