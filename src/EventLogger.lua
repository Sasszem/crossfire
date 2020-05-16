
local IgnoredEvents = {
    -- Basic NATA events
    "add",
    "addToGroup",
    "remove",
    "removeFromGroup",

    -- Custom events to ignore
    "update",
    "draw",
    "collision",
    "debugDraw",
}

-- Create lookup to check if event is ignored
local IE = {}
for _, v in ipairs(IgnoredEvents) do
    IE[v] = true
end
IgnoredEvents = IE


-- table serialization functions
-- straight from http://lua-users.org/wiki/TableSerialization
-- modified to not crash if key is a table
local function table_print (tt, indent, done)
    done = done or {}
    indent = indent or 0
    if type(tt) == "table" then
        local sb = {}
        for key, value in pairs (tt) do
            table.insert(sb, string.rep (" ", indent)) -- indent it
            if type (value) == "table" and not done [value] then
            done [value] = true
            table.insert(sb, tostring(key) .. " = {\n");
            table.insert(sb, table_print (value, indent + 2, done))
            table.insert(sb, string.rep (" ", indent)) -- indent it
            table.insert(sb, "}\n");
            elseif "number" == type(key) then
            table.insert(sb, string.format("\"%s\"\n", tostring(value)))
            else
            table.insert(sb, string.format(
                "%s = \"%s\"\n", tostring (key), tostring(value)))
            end
        end
        return table.concat(sb)
    else
        return tt .. "\n"
    end
end

local function to_string( tbl )
  if  "nil"       == type( tbl ) then
      return tostring(nil)
  elseif  "table" == type( tbl ) then
      return table_print(tbl)
  elseif  "string" == type( tbl ) then
      return tbl
  else
      return tostring(tbl)
  end
end


-- Logger function - may log an event
local function log(args)
    if IgnoredEvents[args[1]] then
        return
    end
    print(to_string(args))
end

-- Factory for replaced emit function
local function logAndProxy(pool)
    -- Calls logger & proxies events
    local function newEmit(self, ...)
        local args = {...}
        log(args)
        pool:oldEmit(unpack(args))
    end
    return newEmit
end


-- installs the new emit to the pool
local function installEventLogger(pool)
    pool.oldEmit = pool.emit
    pool.emit = logAndProxy(pool)
end


-- module exports
return installEventLogger
