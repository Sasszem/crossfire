local ExplosionHit = {}

function ExplosionHit:collision(exp, victim)
    if not self.pool.groups.target.hasEntity[victim] then
        return
    end

    if exp.type ~= "Explosion" then
        return
    end

    if exp.seen[victim] then
        return
    end

    exp.seen[victim] = true

    if victim==exp.parent then
        return
    end

    if victim.type == "Player" then
        return
    end

    self.pool:emit("hit", victim)
end

return ExplosionHit