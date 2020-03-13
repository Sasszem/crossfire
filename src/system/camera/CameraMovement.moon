--- Focus the camera on the player
-- @classmod src.system.camera.CameraMovement
class CameraMovement
    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        camera = @pool.data.camera
        player = @pool.data.player
        camera.position = player.position