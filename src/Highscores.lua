local Highscores = {}

local FILE = "highscores.lst"
local defaultName = "NAMELESS"

function Highscores.load()
    -- load highscores from file
    local t = {}

    if love.filesystem.getInfo(FILE, "file") then
        local re = "[^|]+"
        for line in love.filesystem.lines(FILE) do
            local entry = {}
            if not line:match("|") then
                re = "%w+"
            end
            for word in line:gmatch(re) do
                entry[#entry + 1] = word
            end
            entry[1] = tonumber(entry[1])
            t[#t + 1] = entry
        end
    end
    return t
end

function Highscores.shouldUpdate(score)
    -- return if that score is a highscore or not
    local H = Highscores.load()
    return #H==0 or score>H[1][1]
end

function Highscores.update(score, name)
    if name=="" then name=defaultName end
    local scores = Highscores.load()
    table.insert(scores, {score, name})
    table.sort(scores, function(a, b) return a[1]>b[1] end)
    Highscores.save(scores)
end

function Highscores.save(scores)
    local F = love.filesystem.newFile(FILE, "w")
    for i, sc in ipairs(scores) do
        if i==6 then break end
        F:write(("%s|%s\r\n"):format(sc[1], sc[2]))
    end
    F:close()
end

function Highscores.delete()
    love.filesystem.remove(FILE)
end

return Highscores