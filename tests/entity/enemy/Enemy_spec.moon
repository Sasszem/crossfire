Enemy = require "src.entity.enemy.Enemy"
Vec2 = require "src.Vec2"
Bullet = require "src.entity.bullet.Bullet"

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
        assert.truthy enemy.angle
        assert.is_number enemy.angle
    it "should have a speed", ->
        assert.truthy enemy.speed
        assert.is_number enemy.speed
    --it "should have a turnspeed", ->
    --    assert.truthy enemy.turnspeed
    --    assert.is_number enemy.turnspeed
    it "should have a bullet", ->
        assert.truthy enemy.bullet
        assert.same Bullet, enemy.bullet
    it "should have a shooting cooldown", ->
        assert.truthy enemy.shoot_cooldown
        assert.is_number enemy.shoot_cooldown
    it "should have a refire rate", ->
        assert.truthy enemy.refire_rate
        assert.is_number enemy.refire_rate
    it "should be a target", ->
        assert.truthy enemy.isTarget