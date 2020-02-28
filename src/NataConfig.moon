--- Nata ECS configuration
--- @module src.NataConfig

--- A class-based filter factory. Can filter subclasses if their name contains the superclasses name
-- @tparam string filter the name of the class to filter
-- @treturn function a filter function matching classes with given name
classFilter = (filter) ->
    if type(filter)=="table"
        return (entity) ->
            for f in *filter
                if f==entity.type 
                    return true
            return false
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
            filter: classFilter {"Enemy", "BigEnemy"}
        bullet:
            filter: {'isBullet'}
        target:
            filter: {'isTarget'}
        collision: 
            filter: {'position', 'collision_radius'}
        explosion:
            filter: {'explosion_radius'}
        shoot:
            filter: {'bullet'}
    systems: {
        require "src.system.DespawnSystem"
        require "src.system.CollisionSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
        require "src.system.camera.CameraMovement"
        require "src.system.enemy.EnemyMovement"
        require "src.system.enemy.EnemyAim"
        require "src.system.Shoot"
        require "src.system.BulletCollision"
        require "src.system.ExplosionSystem"
        require "src.system.player.PlayerDrawer"
    }

return NataConfig