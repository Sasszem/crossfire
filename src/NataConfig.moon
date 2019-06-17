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
        enemy:
            filter: classFilter "Enemy"
        bullet:
            filter: classFilter "Bullet"
    systems: {
        require "src.system.DespawnSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
        require "src.system.camera.CameraMovement"
        require "src.system.enemy.EnemyMovement"
        require "src.system.enemy.EnemyAim"
    }

return NataConfig