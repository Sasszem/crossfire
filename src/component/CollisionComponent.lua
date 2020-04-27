
local function CollisionComponent(collisionRadius)
    return {
        collisionRadius = collisionRadius or 10
    }
end

return CollisionComponent