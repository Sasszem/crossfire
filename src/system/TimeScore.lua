local TimeScore = {}
TimeScore.__index = TimeScore

function TimeScore:init()
    self.cooldown = 1
end

function TimeScore:update(dt)
    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self.pool.data.score = self.pool.data.score + 1
        self.cooldown = self.cooldown + 1
    end
end

return TimeScore