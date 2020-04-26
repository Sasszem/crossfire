--- Nata ECS configuration
--- @module src.NataConfig

nata = require "lib.nata.nata"

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

loadedSystems = require "src.AllSystems"

systems = {}
for i, s in ipairs(loadedSystems)
    systems[#systems + 1] = s

systems[#systems + 1] = nata.oop({
    include: {"draw"}
    group: "draw"
})

systems[#systems + 1] = nata.oop({
    exclude: {"draw"}
})

--- Nata groups and systems configuration 
-- @table NataConfig
NataConfig = 
    groups:
        all:  {},
        draw:
            filter: {'draw'}
            sort: (a, b) ->
                dA = a.drawLayer or 0
                dB = b.drawLayer or 0
                aA = a.age or 0
                aB = b.age or 0
                return (dA < dB) or ((dA==dB) and (aA > aB))
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
    :systems

return NataConfig
