nata = require "lib.nata"
NataConfig = require "src.NataConfig"
CollisionSystem = require "src.system.CollisionSystem"
Vec2 = require "src.Vec2"

CollidableEntity = (position = Vec2!) ->
    {
        :position
        collision_radius: 10
        type: "CollidableEntity"
    }


describe "CollisionSystem", ->
    -- setup environment
    pool = nata.new {
        groups: NataConfig.groups
        systems: {CollisionSystem}
    }

    entity1 = CollidableEntity!
    entity2 = CollidableEntity Vec2(5,5)
    entity3 = CollidableEntity Vec2(20,20)

    pool\queue entity1
    pool\queue entity2
    pool\queue entity3
    pool\flush!


    -- get instance
    instance = pool\getSystem CollisionSystem

    it "should be imported", ->
        assert.truthy CollisionSystem

    it "should be createable", ->
        assert.truthy CollisionSystem!

    it "should be added to the pool", ->
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should create collision events", ->
        collisionSpy = spy.new (entity1, entity2) -> 
        pool\on("collision", collisionSpy)

        pool\emit "update", 1 -- dt does not matter here

        assert.spy(collisionSpy).was.called(2)
        assert.spy(collisionSpy).was.called_with(entity1, entity2)
        assert.spy(collisionSpy).was.called_with(entity2, entity1)
