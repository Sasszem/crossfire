local function buildEntity(type, ...)
    local entity = {
        type = type
    }
    for _, component in ipairs({...}) do
        for k,v in pairs(component) do
            entity[k] = v
        end
    end
    return entity
end

return buildEntity