function rgb(r, g, b, a)
    a = a or 255
    return {r/255, g/255, b/255, a/255}
end

function fade(color, factor)
    return {color[1], color[2], color[3], factor*color[4]}
end

function sign(num) 
    if num>0 then
        return 1
    else
        if num==0 then
            return 0
        else
            return -1
        end
    end
end

function cropAngle(angle)
    local x = angle
    while x < 0 do
        x = x + 360
    end
    while x >= 360 do
        x = x - 360
    end
    return x
end