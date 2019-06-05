NataConfig = 
    groups: 
        all:  {},
        velocity: 
            filter: {'position', 'velocity'}
        despawn:
            filter: {'despawnTimer'}
        orb:
            filter: (entity) -> 
                entity.__class.__name == "Orb"
    systems: {
        require "src.system.DespawnSystem"
        require "src.system.orb.OrbMovement"
        require "src.system.VelocitySystem"
    }

return NataConfig