nata = require "lib.nata"
NataConfig = require "src.NataConfig"
CameraMovement = require "src.system.camera.CameraMovement"
Camera = require "src.entity.camera.Camera"
Player = require "src.entity.player.Player"
Vec2 = require "src.Vec2"

describe "CameraMovement", ->
    -- setup environment
    
    camera = Camera Vec2!
    player = Player Vec2 math.random(10), math.random(10)

    pool = nata.new {
        groups: NataConfig.groups
        systems: {CameraMovement}
        data:
            :player
            :camera
    }

    pool\queue camera
    pool\queue player
    pool\flush!

    -- get instance
    instance = pool\getSystem CameraMovement

    it "should be imported", ->
        assert.truthy CameraMovement

    it "should be createable", ->
        assert.truthy CameraMovement!

    it "should be added to the pool", ->
        assert.equals 1, #pool._systems
        assert.truthy instance

    it "should have an 'update' listener", ->
        assert.is_function instance.update

    it "should update the cameras position", ->
        dt = math.random 10

        pool\emit "update", dt
        
        assert.same player.position, camera.position
        
    