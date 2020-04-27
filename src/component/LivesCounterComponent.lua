local function LivesCounterComponent(lives)
    return {
        lives = lives or 3
    }
end

return LivesCounterComponent