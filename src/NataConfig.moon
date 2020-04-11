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
        position:
            filter: {'position'}
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
        require "src.system.BackgroundDrawer"
        require "src.system.WallDrawer"
        require "src.system.DespawnSystem"
        require "src.system.CollisionSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
        require "src.system.camera.CameraMovement"
        require "src.system.enemy.EnemyHit"
        require "src.system.enemy.EnemyDrawer"
        require "src.system.enemy.EnemySpawner"
        require "src.system.Shoot"
        require "src.system.WallSystem"
        require "src.system.BulletCollision"
        require "src.system.enemy.ExplosionSpawner"
        require "src.system.enemy.ExplosionHit"
        require "src.system.player.PlayerDrawer"
        require "src.system.player.PlayerMovement"
        require "src.system.FPSDrawer"
        require "src.system.enemy.BulletDrawer"
        require "src.system.player.Shield"
        require "src.system.player.Hit"
        require "src.system.player.ShockWave"
        require "src.system.orb.OrbSpawner"
        require "src.system.orb.OrbDrawer"
        require "src.system.player.OrbCollect"
        require "src.system.ScoreDrawer"
        require "src.system.enemy.AI"
    }

return NataConfig
