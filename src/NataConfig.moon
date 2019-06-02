NataConfig = 
    groups: 
        all:  {},
        velocity: 
            filter: {'position', 'velocity'}
        despawn:
            filter: {'despawnTimer'}
    systems: {
        require "src.system.DespawnSystem"
    }

return NataConfig