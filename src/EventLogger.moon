
import p from require "moon"

IgnoredEvents = {
    -- Basic NATA events
    "add"
    "addToGroup"
    "remove"
    "removeFromGroup"

    -- Custom events to ignore
    "update"
    "draw"
    "collision"
    "debugDraw"
}

-- Create lookup to check if event is ignored
IE = {}
for _, v in pairs IgnoredEvents
    IE[v] = true
IgnoredEvents = IE

-- Logger function - may log an event
log = (args) ->
    if IgnoredEvents[args[1]]
        return
    p(args)

-- Factory for replaced emit function
logAndProxy = (pool) ->
    -- Calls logger & proxies events
    newEmit = (...) =>
        args = {...}
        log(args)
        pool\oldEmit(unpack(args))
    return newEmit

-- installs the new emit to the pool
installEventLogger = (pool) ->
    pool.oldEmit = pool.emit
    pool.emit = logAndProxy(pool)

-- module exports
{
    :installEventLogger
}
