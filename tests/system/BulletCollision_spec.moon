nata = require "lib.nata"
NataConfig = require "src.NataConfig"
BulletCollision = require "src.system.BulletCollision"
CollisionSystem = require "src.system.CollisionSystem"
Bullet = require "src.entity.bullet.Bullet"
Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

SomeCollidable = (position) ->
    {
        :position
        collision_radius: 20
        isTarget: true
        type: "SomeCollidable"
    }

describe "BulletCollision", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {BulletCollision, CollisionSystem}
    }

    player = Player Vec2 math.random(10), math.random(10)
    bullet = Bullet player.position
    bullet2 = Bullet player.position

    other = SomeCollidable player.position

    pool\queue player
    pool\queue bullet
    pool\queue bullet2
    pool\queue other
    pool\flush!

    -- get instance
    instance = pool\getSystem BulletCollision

    it "should be imported", ->
        assert.truthy BulletCollision

    it "should be createable", ->
        assert.truthy BulletCollision!

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
        
    