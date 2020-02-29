class Wall
    init: =>
        @size = 200
    update: (dt) =>
        for ent in *@pool.groups.position.entities
            with ent.position
                .x = math.max .x, -@size
                .x = math.min .x, @size
                .y = math.max .y, -@size
                .y = math.min .y, @size