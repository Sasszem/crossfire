AIComponent = (movetarget, movespeed, turnrate, movetreshold, turntreshold) ->
    {
        :movespeed -- px / sec
        :turnrate -- °/sec
        :movetreshold -- px
        :turntreshold -- °
        :movetarget
        state: "locked"
    }

return AIComponent
