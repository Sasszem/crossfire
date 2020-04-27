--- Nata ECS configuration
--- @module src.NataConfig

local nata = require("lib.nata.nata")

--- A class-based filter factory. Can filter subclasses if their name contains the superclasses name
-- @tparam string filter the name of the class to filter
-- @treturn function a filter function matching classes with given name
local function classFilter(filter)
    if type(filter)=="table" then
        return function(entity)
            for _, f in ipairs(filter) do
                if f==entity.type then
                    return true
                end
            end
            return false
        end
    end

    return function(entity)
        return entity.type==filter
    end
end

local loadedSystems = require "src.AllSystems"

local systems = {}
for i, s in ipairs(loadedSystems) do
    systems[#systems + 1] = s
end

systems[#systems + 1] = nata.oop({
    include = {"draw"},
    group = "draw"
})

systems[#systems + 1] = nata.oop({
    exclude = {"draw"}
})

--- Nata groups and systems configuration
-- @table NataConfig
local NataConfig = {
    groups = {
        all = {},
        draw = {
            filter = {'draw'},
            sort = function(a, b)
                local dA = a.drawLayer or 0
                local dB = b.drawLayer or 0
                local aA = a.age or 0
                local aB = b.age or 0
                return (dA < dB) or ((dA==dB) and (aA > aB))
            end
        },
        position = {
            filter = {'position'}
        },
        velocity = {
            filter = {'position', 'velocity'}
        },
        despawn = {
            filter = {'despawnTimer'}
        },
        orb = {
            filter = classFilter("Orb")
        },
        camera = {
            filter = classFilter("Camera")
        },
        player = {
            filter = classFilter("Player")
        },
        enemy = {
            filter = classFilter({"Enemy", "BigEnemy"})
        },
        bullet = {
            filter = {'isBullet'}
        },
        target = {
            filter = {'isTarget'}
        },
        collision = {
            filter = {'position', 'collisionRadius'}
        },
        shoot = {
            filter = {'bullet'}
        }
    },
    systems = systems
}
return NataConfig
