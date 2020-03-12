--- Camera is a "dummy" entity always following the current @{src.entity.player.Player} and used to focus the view on it
-- @classmod src.entity.camera.Camera

buildEntity = require "src.entity.buildEntity"
C = require "src.Components"

Camera = (position) ->
    buildEntity "Camera",
        C.PositionComponent(position)

return Camera