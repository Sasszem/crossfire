nata = require "lib.nata"
NataConfig = require "src.NataConfig"
BulletExplosionSystem = require "src.system.bullet.BulletExplosionSystem"
CollisionSystem = require "src.system.CollisionSystem"
ExplodingBullet = require "src.entity.bullet.ExplodingBullet"
Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

describe "BulletExplosionSystem", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {BulletExplosionSystem, CollisionSystem}
    }

    player = Player Vec2 math.random(10), math.random(10)
    bullet = ExplodingBullet player.position

    other = Player player.position

    pool\queue player
    pool\queue bullet
    pool\queue other
    pool\flush!

    -- get instance
    instance = pool\getSystem BulletExplosionSystem

    it "should be imported", ->
        assert.truthy BulletExplosionSystem

    it "should be createable", ->
        assert.truthy BulletExplosionSystem!

    it "should be added to the pool", ->
        assert.equals 2, #pool._systems
        assert.truthy instance

    it "should have a 'collision' listener", ->
        assert.is_function instance.collision

    it "should emit 'hit' events", ->
        hitSpy = spy.new (victim) ->
        pool\on "hit", hitSpy

        pool\emit "update", 1
        
        assert.spy(hitSpy).was.called(4)
        assert.spy(hitSpy).was.called_with(player)
        assert.spy(hitSpy).was.called_with(other)
        
    