--- A system updating despawn timers and removing despawned entities 
-- @classmod src.system.DespawnSystem
class DespawnSystem

    --- update event handler
    -- @tparam number dt delta-time since prev. call
    update: (dt) =>
        for entity in *@pool.groups.despawn.entities
            with entity
                if .despawnTimer > 0
                    -- update timer
                    .despawnTimer -= dt
            @pool\remove (entity) ->
                with entity
                    if .despawnTimer
                        if .despawnTimer <= 0 and .despawnTimer != -1
                        -- -1 is the special value of disabled despawn timer
                            return true
                    return false
