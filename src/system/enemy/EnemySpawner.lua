require "src.utils"

local Vec2 = require "src.Vec2"

local Enemy = require "src.entity.enemy.Enemy"
local BigEnemy = require "src.entity.enemy.BigEnemy"

-- TODO: Refactor this
local e = Enemy()
local eMt = e.movetarget
local eT = e.movetreshold
local b = BigEnemy()
local bMt = b.movetarget
local bT = b.movetreshold

local EnemySpawner = {}

local function outside(pos, D)
    return math.abs(pos.x)>=D or math.abs(pos.y)>=D
end

function EnemySpawner:init()
    self.enemyCount = 0
    self.bigEnemyCount = 0
    self.cooldown = 1
    self.period = 2
end

function EnemySpawner:update(dt)
    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        local should_have_enemy, should_have_bigEnemy = self:should_have()

        local player = self.pool.groups.player.entities[1]
        local ofset = nil
        while not ofset or outside(player.position + ofset, self.pool.data.config.wallSize) do
            ofset = Vec2.fromAngle(math.random(360), math.random(100, 150))
        end

        local spawnPos = player.position+ofset, self.pool.data.config.wallSize

        if self.bigEnemyCount < should_have_bigEnemy then
            local bE = BigEnemy(spawnPos)
            self.pool:queue(bE)
            self.cooldown = self.period
            self.pool:emit("spawn", bE)
            self.bigEnemyCount = self.bigEnemyCount + 1
            return
        end

        if self.enemyCount < should_have_enemy then
            local e = Enemy(spawnPos)
            self.pool:queue(e)
            self.cooldown = self.period
            self.pool:emit("spawn", e)
            self.enemyCount = self.enemyCount + 1
            return
        end
    end
end

function EnemySpawner:EnemyDeath(pos, type)
    if type=="Enemy" then
        self.enemyCount = self.enemyCount - 1
    end
    if type == "BigEnemy" then
        self.bigEnemyCount = self.bigEnemyCount - 1
    end
end


function EnemySpawner:should_have()
    should_have_enemy = math.min(math.floor(self.pool.data.score / 30) + 3, 6)
    should_have_bigEnemy = math.min(math.floor(self.pool.data.score / 50), 2)
    return should_have_enemy, should_have_bigEnemy
end



-- debug draw
function EnemySpawner:debugDraw()
    -- move target circles
    local p = self.pool.groups.player.entities[1]
    love.graphics.setLineWidth(2)
    love.graphics.setColor(rgb(255, 255, 255))
    love.graphics.circle("line", p.position.x, p.position.y, eMt-eT)
    love.graphics.circle("line", p.position.x, p.position.y, eMt+eT)
    love.graphics.setColor(rgb(0, 255, 0))
    love.graphics.circle("line", p.position.x, p.position.y, bMt-bT)
    love.graphics.circle("line", p.position.x, p.position.y, bMt+bT)

    -- enemy states
    love.graphics.setColor(rgb(255, 255, 255))
    for _, en in ipairs(self.pool.groups.enemy.entities) do
        love.graphics.print(en.state, en.position.x, en.position.y)
    end

    local should_have_enemy, should_have_bigEnemy = self:should_have()


    -- counts and should-haves
    love.graphics.push()
    love.graphics.origin()
    love.graphics.print("Should have E: "..tostring(should_have_enemy), 10, 30)
    love.graphics.print("Should have bE: "..tostring(should_have_bigEnemy), 10, 50)
    love.graphics.print("Has E: "..tostring(self.enemyCount), 10, 70)
    love.graphics.print("Has bE: "..tostring(self.bigEnemyCount), 10, 90)
    love.graphics.pop()
end

return EnemySpawner
        
        
        