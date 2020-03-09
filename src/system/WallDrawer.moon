class WallDrawer
    init: =>
        @D = 200
    draw: =>
        love.graphics.setColor {255/255, 0/255, 102/255}
        love.graphics.setLineWidth 10
        love.graphics.line -@D, -@D, -@D,  @D
        love.graphics.line -@D,  @D,  @D,  @D
        love.graphics.line  @D,  @D,  @D, -@D
        love.graphics.line  @D, -@D, -@D, -@D