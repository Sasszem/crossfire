Vec2 = require "src.Vec2"

class CameraMovement
    update: (dt) =>
        camera = @pool.groups.camera.entities[1]
        player = @pool.groups.player.entities[1]
        camera.position = player.position