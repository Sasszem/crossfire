--- Nata ECS configuration
--- @module src.NataConfig

--- A class-based filter factory. Can filter subclasses if their name contains the superclasses name
-- @tparam string filter the name of the class to filter
-- @treturn function a filter function matching classes with given name
classFilter = (filter) ->
    if type(filter)=="table"
        error("Not implemented yet!")
    (entity) -> 
        entity.type == filter

--- Nata groups and systems configuration 
-- @table NataConfig
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
        collision: 
            filter: {'position', 'collision_radius'}
    systems: {
        require "src.system.DespawnSystem"
        require "src.system.CollisionSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
        require "src.system.camera.CameraMovement"
        require "src.system.enemy.EnemyMovement"
        require "src.system.enemy.EnemyAim"
        require "src.system.bullet.BulletCollisionResolver"
    }

return NataConfig