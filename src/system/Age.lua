local Age = {}

function Age:add(e)
    e.age = 0
end

function Age:update(dt)
    for _, e in ipairs(self.pool.entities) do
        e.age = e.age + dt
    end
end

return Age