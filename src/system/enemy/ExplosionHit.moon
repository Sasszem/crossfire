class ExplosionHit
    collision: (exp, victim) =>
        if not @pool.groups.target.hasEntity[victim]
            return
        if exp.type != "Explosion"
            return
        if exp.seen[victim]
            return
        
        exp.seen[victim] = true
        
        if victim.state == "Shield"
            return
        if victim==exp.parent
            return
        
        if victim.type == "Player"
            return
        
        @pool\emit "hit", victim