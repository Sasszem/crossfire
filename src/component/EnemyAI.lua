local function AIComponent(movetarget, movespeed, turnrate, movetreshold, turntreshold)
    return {
        movespeed = movespeed, -- px / sec
        turnrate = turnrate, -- °/sec
        movetreshold = movetreshold, -- px
        turntreshold = turntreshold, -- °
        movetarget = movetarget,
        state = "locked",
    }
end 

return AIComponent
