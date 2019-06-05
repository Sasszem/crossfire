lfs = require "lfs"

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
        os.execute "mkdir -p "..dest_dir
        os.execute "cp "..path.." "..dest_path

recursive_delete = (src, exclude, filter) ->
    run_recursive src, exclude, (path) ->
        if string.match(path, filter)
            os.execute "rm -f "..path

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
    os.execute "moonc ./build/"
    recursive_delete "./build/", {}, ".*%.moon$"

test = ->
    build!
    os.execute "cd build && busted . -c"
    os.execute "cd build && luacov"

package = ->
    build!
    os.execute "cd build && zip -r ../game.love ./*"

clean = ->
    os.execute "rm -rf build game.love"
    recursive_delete ".", {"/lib/"}, ".*%.lua$"
    recursive_delete ".", {}, "luacov%..*%.out$"

lint = ->
    os.execute "moonc -l ."

runner = 
    :test
    :package
    :clean
    :lint

runner[arg[1]]!