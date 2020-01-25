BigEnemy = require "src.entity.enemy.BigEnemy"
Vec2 = require "src.Vec2"
ExplodingBullet = require "src.entity.bullet.ExplodingBullet"

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
        assert.truthy bigEnemy.angle
        assert.is_number bigEnemy.angle
    it "should have a speed", ->
        assert.truthy bigEnemy.speed
        assert.is_number bigEnemy.speed
    --it "should have a turnspeed", ->
    --    assert.truthy bigEnemy.turnspeed
    --    assert.is_number bigEnemy.turnspeed
    it "should have a bullet", ->
        assert.truthy bigEnemy.bullet
        assert.same ExplodingBullet, bigEnemy.bullet
    it "should have a shooting cooldown", ->
        assert.truthy bigEnemy.shoot_cooldown
        assert.is_number bigEnemy.shoot_cooldown
    it "should have a refire rate", ->
        assert.truthy bigEnemy.refire_rate
        assert.is_number bigEnemy.refire_rate