--- Focus the camera on the player
-- @classmod src.system.camera.CameraMovement
class CameraMovement
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        camera = @pool.groups.camera.entities[1]
        player = @pool.groups.player.entities[1]
        camera.position = player.position