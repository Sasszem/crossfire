classFilter = (filter) ->
    (entity) -> 
        string.find(entity.__class.__name, filter) != nil

NataConfig = 
    groups: 
        all:  {},
        velocity: 
            filter: {'position', 'velocity'}
        despawn:
            filter: {'despawnTimer'}
        orb:
            filter: classFilter "Orb"
        camera:
            filter: classFilter "Camera"
        player:
            filter: classFilter "Player"
    systems: {
        require "src.system.DespawnSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
        require "src.system.camera.CameraMovement"
    }

return NataConfig