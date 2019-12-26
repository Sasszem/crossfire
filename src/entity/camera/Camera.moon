--- Camera is a "dummy" entity always following the current @{src.entity.player.Player} and used to focus the view on it
-- @classmod src.entity.camera.Camera

Vec2 = require "src.Vec2"

Camera = (pos = Vec2!) =>
    {
        type: "Camera"
        position: pos
    }
return Camera