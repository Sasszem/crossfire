local Wall = {}

function Wall:init()
    self.size = 400
end

function Wall:update(dt)
    for _, ent in ipairs(self.pool.groups.position.entities) do
        -- ignore ShockWave
        if ent.type~="ShockWave" then
            local x = ent.position.x
            local y = ent.position.y
            local s = self.size
            if ent.collision_radius then
                s = s - ent.collision_radius
            end

            ent.wallCollision = (math.abs(ent.position.x)>=s) or (math.abs(ent.position.y)>=s)
            
            if not self.pool.groups.bullet.hasEntity[ent] then
                x = math.min(x, s)
                x = math.max(x, -s)
                y = math.min(y, s)
                y = math.max(y, -s)
                ent.position.x = x
                ent.position.y = y
            end
        end
    end
end

return Wall