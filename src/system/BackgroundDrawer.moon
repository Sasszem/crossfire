class BackgroundDrawer
    draw: =>
        pos = @pool.data.camera.position
        love.graphics.setLineWidth 1
        love.graphics.setColor {0/255, 204/255, 204/255}
        beginX = math.floor((pos.x - 500) / 50) * 50
        beginY = pos.y - 400
        endY = pos.y + 400
        for i = 0, 20
            x = beginX + 50*i
            love.graphics.line x, beginY, x, endY
        beginY =  math.floor((pos.y - 400) / 50) * 50
        beginX = pos.x - 500
        endX = pos.x + 500
        for i = 0, 16
            y = beginY + 50 * i
            love.graphics.line beginX, y, endX, y

        love.graphics.setColor {204/255, 41/255, 0/255}
        love.graphics.setLineWidth 3
        beginX = math.floor((pos.x - 500) / 100) * 100
        for i = 0, 10
            x = beginX + 100*i
            love.graphics.line x, beginY, x, endY
        beginY =  math.floor((pos.y - 400) / 100) * 100
        beginX = pos.x - 500
        endX = pos.x + 500
        for i = 0, 16
            y = beginY + 100 * i
            love.graphics.line beginX, y, endX, y