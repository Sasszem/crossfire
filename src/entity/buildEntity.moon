buildEntity = (type, ...) ->
    entity = {
        :type
    }
    for component in *{...}
        for k,v in pairs component
            entity[k] = v
    return entity

return buildEntity