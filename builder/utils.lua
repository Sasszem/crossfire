
function magiclines(s)
    if s:sub(-1) ~= "\n" then
        s = s .. "\n"
    end
    return s:gmatch("(.-)\n")
end

function endswith(str, endstr)
    return endstr == "" or str:sub(-#endstr) == endstr
end

function append_path(path, file)
    if string.sub(path, -1) ~= "/" then
        path = path .. "/"
    end
    return path .. file
end

function capture_command(cmd)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    local exitcode = f:close()
    return s, exitcode
end

function run_command(cmd, ignore_error)
    local result = os.execute(cmd)
    if not (result==0 or result==true or ignore_error) then
        os.exit(-1)
    end
    return result
end