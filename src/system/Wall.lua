local Wall = {}

function Wall:init()
    self.size = self.pool.data.config.wallSize
end

function Wall:update(dt)
    for _, ent in ipairs(self.pool.groups.position.entities) do
        -- ignore ShockWave
        if ent.type~="ShockWave" and ent.type~="Explosion" then
            local x = ent.position.x
            local y = ent.position.y
            local s = self.size
            if ent.collisionRadius then
                s = s - ent.collisionRadius
            end

            ent.wallTouch = math.abs(ent.position.x)>=s or math.abs(ent.position.y)>=s

            if not self.pool.groups.bullet.hasEntity[ent] then
                x = math.min(x, s)
                x = math.max(x, -s)
                y = math.min(y, s)
                y = math.max(y, -s)
                ent.position.x = x
                ent.position.y = y
            else
                local set = false
                if ent.position.x > s then
                    ent.velocity.x = -math.abs(ent.velocity.x)
                    set = true
                end
                if ent.position.x < -s then
                    ent.velocity.x = math.abs(ent.velocity.x)
                    set = true
                end

                if ent.position.y > s then
                    ent.velocity.y = -math.abs(ent.velocity.y)
                    set = true
                end
                if ent.position.y < -s then
                    ent.velocity.y = math.abs(ent.velocity.y)
                    set = true
                end

                if set then
                    ent.position = ent.position + ent.velocity * 0.01
                    ent.despawnTimer = math.min(ent.despawnTimer + 5, 15)
                    ent.parent = nil
                end
            end
        end
    end
end

return Wall