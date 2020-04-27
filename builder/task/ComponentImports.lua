require("builder.utils")

local function GenerateComponentImports()
    local all_lua = capture_command('cd src/component/ && find . -name "*.lua"')

    local file_object = io.open("src/Components.lua", "w")
    file_object:write("-- AUTO-GENERATED IMPORTS FILE\n")
    file_object:write("-- GETS DISCARDED EVERY TIME\n")
    file_object:write("-- AND A NEW ONE IS GENERATED\n")
    file_object:write("-- DO NOT COMMIT THIS FILE!\n")
    file_object:write("\n")
    file_object:write("\n")
    file_object:write("local Components = {\n")

    local sCount = 0

    for line in magiclines(all_lua) do
        local className, _ = string.sub(line, 2, -5):gsub("/", "."):sub(2)
        file_object:write("    "..className.." = require(\"src.component."..className.."\"),\n")
        sCount = sCount + 1
    end

    file_object:write("}\n")
    file_object:write("\n")
    file_object:write("return Components\n")
    file_object:close()

    print("Auto-imported "..tostring(sCount).." components!")
end

return GenerateComponentImports