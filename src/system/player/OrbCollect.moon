class OrbCollect
    collision: (orb, player) =>
        if not @pool.groups.orb.hasEntity[orb]
            return
        if not @pool.groups.player.hasEntity[player]
            return

        orb.despawnTimer = 0
        @pool.data.score += 1
