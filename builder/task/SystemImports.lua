local function GenerateSystemImports()
    local all_lua = capture_command('cd src/system/ && find . -name "*.lua"')

    local file_object = io.open("src/AllSystems.lua", "w")
    file_object:write("-- AUTO-GENERATED IMPORTS FILE\n")
    file_object:write("-- GETS DISCARDED EVERY TIME\n")
    file_object:write("-- AND A NEW ONE IS GENERATED\n")
    file_object:write("-- DO NOT COMMIT THIS FILE!\n")
    file_object:write("\n")
    file_object:write("\n")
    file_object:write("local AllSystems = {\n")

    local count = 0

    for line in magiclines(all_lua) do
        local className, _ = string.sub(line, 2, -5):gsub("/", ".")
        file_object:write("    require(\"src.system"..className.."\"),\n")
        count = count + 1
    end

    file_object:write("}\n")
    file_object:write("\n")
    file_object:write("return AllSystems\n")
    file_object:close()

    print("Auto-imported "..tostring(count).." systems!")
end

return GenerateSystemImports
