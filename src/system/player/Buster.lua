local BusterSystem = {}
BusterSystem.__index = BusterSystem

function BusterSystem:collision(player, enemy)
    if not self.pool.groups.player.hasEntity[player] then
        return
    end
    if not self.pool.groups.enemy.hasEntity[enemy] then
        return
    end
    if player.state ~= "Buster" then
        return
    end
    self.pool:emit("hit", enemy)
end

return BusterSystem