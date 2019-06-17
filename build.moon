lfs = require "lfs"

run_command = (cmd, ignore = false) ->
    result = os.execute cmd
    --print "command \""..cmd.."\" returned "..tostring(ret_code)
    if not (result==0 or result==true or ignore)
        os.exit -1

append_path = (path, file) ->
    if string.sub(path, -1) != "/"
        path ..= "/"
    path .. file

copy_file = (src, dest) ->
    os.execute("cp "..src.." "..dest)

make_dir = (path) ->
    os.execute("mkdir -p "..path)

run_recursive = (src, excludes, callback) ->
    for file in lfs.dir src
        cnt = false

        if file=="." or file==".."
            continue
        
        full_path = append_path(src, file)

        for exclude in *excludes
            if string.find(full_path, exclude)!=nil
                print "Ignore: "..full_path
                print "Rule: "..exclude
                cnt = true
        if cnt==true
            continue
        
        if lfs.attributes(full_path).mode == "directory"
            run_recursive append_path(src, file), excludes, callback
        else
            callback full_path

recursive_copy = (src, dest, exclude) ->
    run_recursive src, exclude, (path) ->
        dest_path = dest..string.sub(path, 2)
        dest_dir = string.match(dest_path, ".*/")
        run_command "mkdir -p "..dest_dir
        run_command "cp "..path.." "..dest_path

recursive_delete = (src, exclude, filter) ->
    run_recursive src, exclude, (path) ->
        if string.match(path, filter)
            run_command "rm -f "..path

build_ignore = {
    "%./build/"
    "%.git/"
    "Makefile"
    "%.MD$"
    "%.vscode/"
    "doc/"
    "build%.moon"
    "LICENSE"
    "%.gitignore"
    "game%.zip"
}


build = ->
    recursive_copy ".", "./build", build_ignore
    run_command "moonc ./build/"
    recursive_delete "./build/", {}, ".*%.moon$"

test = ->
    build!
    run_command "cd build && busted . -c"
    run_command "cd build && luacov"

package = ->
    build!
    run_command "cd build && zip -r ../game.love ./*"

clean = ->
    run_command "rm -rf build game.love"
    recursive_delete ".", {"/lib/"}, ".*%.lua$"
    recursive_delete ".", {}, "luacov%..*%.out$"

lint = ->
    run_command "moonc -l ."

runner = 
    :test
    :package
    :clean
    :lint

runner[arg[1]]!