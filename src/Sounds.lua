local flux = require("lib.flux.flux")

local soundTweens = flux.group()

local ignoreEffects = {
    "music1",
    "music3",
    "menu"
}
local ignore = {}
for _, v in ipairs(ignoreEffects) do
    ignore[v] = true
end

local Sounds = {
    soundCache = {},
    playing = {},
    LPF = false,
    SLOW = false,
    music = {},
    currentMusic = nil,
    t = 0,
    slowdownSource = nil,
    slowdownMusic = nil,
    options = {},
}

function Sounds:update(dt)
    if math.floor(self.t)<math.floor(self.t + dt) then
        self:cleanup()
    end
    self.t = self.t + dt
    soundTweens:update(dt)
    if self.slowdownSource then
        local slowdownFactor = self.slowdownSource.slowdownFactor
        for k, _ in pairs(self.playing) do
            if not ignore[k] then
                k:setPitch(slowdownFactor)
            end
        end
        for k, _ in pairs(self.music) do
            if not ignore[k] then
                self:getSource(k):setPitch(slowdownFactor)
            end
        end
    end
    self:setVolumesFromOptions()
end

function Sounds:getOptionsVolumes()
    local effectsVolume = 1
    local musicVolume = 1
    if not (self.options.music and self.options.sounds) then
        musicVolume = 0
    end
    if not (self.options.effects and self.options.sounds) then
        effectsVolume = 0
    end
    return musicVolume, effectsVolume
end

function Sounds:setVolumesFromOptions()
    local musicVolume, effectsVolume = self:getOptionsVolumes()

    for k, name in pairs(self.playing) do
        k:setVolume(effectsVolume)
    end
    for k, _ in pairs(self.music) do
        self:getSource(k):setVolume(musicVolume)
    end
end

function Sounds:cleanup()
    for k, _ in pairs(self.playing) do
        if not k:isPlaying() then
            self.playing[k] = nil
            ignore[k] = nil
            k:release()
        end
    end
end

local streamingTreshold = 60000

function Sounds:getSource(name)
    if not self.soundCache[name] then
        local filename = "asset/"..name..".ogg"
        local fileInfo = assert(love.filesystem.getInfo(filename))
        local sourceType = "static"
        if fileInfo.size>streamingTreshold then
            sourceType = "stream"
        end
        self.soundCache[name] = love.audio.newSource(filename, sourceType)
    end
    if self.soundCache[name]:getType()=="static" then
        return self.soundCache[name]:clone()
    end
    return self.soundCache[name]
end

function Sounds:insert(source)
    self.playing[source] = true
    self:applyEffects(source)
end

function Sounds:applyEffects(source)
    if ignore[source] then return false end
    source:setFilter()
    if self.LPF then
        source:setFilter({
            type="lowpass",
            volume=0.2,
            highgain=1,
        })
    end
end

function Sounds:effect(name)
    local effect = self:getSource(name)
    if ignore[name] then
        ignore[effect] = true
    end

    local _, effectsVolume = self:getOptionsVolumes()

    self:insert(effect)
    effect:setVolume(effectsVolume)
    effect:play()
end

function Sounds:setBackgroundMusic(name)
    local music = self:getSource(name)
    if ignore[name] then
        ignore[music] = true
    end
    self.music[name] = 0.1
    local fS = {}
    fS[name] = 1
    if self.currentMusic then
        fS[self.currentMusic] = 0
    end
    music:stop()
    music:setLooping(true)
    local musicVolume, _ = self:getOptionsVolumes()
    music:setVolume(musicVolume)
    music:play()
    soundTweens:to(self.music, 0.5,fS):onupdate(function()
        for k, v in pairs(self.music) do
            self:getSource(k):setVolume(v)
            if v==0 then
                self:getSource(k):stop()
            end
        end
    end)
    self.currentMusic = name
end

function Sounds:setLPF(state)
    self.LPF = state
    for k, _ in pairs(self.playing) do
        self:applyEffects(k)
    end
    self:applyEffects(self:getSource(self.currentMusic))
end

function Sounds:setSlowdown(src, music)
    self.slowdownSource = src
    self.slowdownMusic = music
end

function Sounds:setOptions(options)
    self.options = options
end

return Sounds