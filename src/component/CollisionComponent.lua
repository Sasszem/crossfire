
local function CollisionComponent(collision_radius)
    return {
        collision_radius = collision_radius or 10
    }
end

return CollisionComponent