lfs = require "lfs"

magiclines = (s) ->
    if s\sub(-1) != "\n"
        s ..= "\n"
    s\gmatch "(.-)\n"

run_command = (cmd, ignore = false) ->
    result = os.execute cmd
    --print "command \""..cmd.."\" returned "..tostring(ret_code)
    if not (result==0 or result==true or ignore)
        os.exit -1
    return result

capture_command = (cmd, ignore=false) ->
    f = assert io.popen cmd, 'r'
    s = assert f\read '*a'
    exitcode = f\close!
    return s, exitcode
        
    

append_path = (path, file) ->
    if string.sub(path, -1) != "/"
        path ..= "/"
    path .. file

copy_file = (src, dest) ->
    run_command "cp #{src} #{dest}"

make_dir = (path) ->
    run_command "mkdir -p #{path}"

delete_file = (path) ->
    run_command "rm -f #{path}"

run_recursive = (src, excludes, callback) ->
    for file in lfs.dir src
        cnt = false

        if file=="." or file==".."
            continue
        
        full_path = append_path(src, file)

        for exclude in *excludes
            if string.find(full_path, exclude)!=nil
                print "Ignore: #{full_path}"
                print "Rule: #{exclude}"
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
        make_dir dest_dir
        copy_file path, dest_path

recursive_delete = (src, exclude, filter) ->
    run_recursive src, exclude, (path) ->
        if string.match(path, filter)
            delete_file path

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



endswith = (str, endstr) ->
    endstr == "" or str\sub(-#endstr) == endstr

generate_component_imports = ->
    src_dir = "src/component"
    
    file_object = io.open "src/Components.moon", "w"
    file_object\write "-- AUTO-GENERATED IMPORTS FILE\n"
    file_object\write "-- GETS DISCARDED EVERY TIME\n"
    file_object\write "-- AND A NEW ONE IS GENERATED\n"
    file_object\write "-- DO NOT COMMIT THIS FILE!\n"

    file_object\write "Components = \n"
    for file in lfs.dir src_dir
        if file=="." or file==".."
            continue
        
        full_path = append_path(src_dir, file)
        
        if lfs.attributes(full_path).mode == "file"
            if endswith full_path, "moon"
                without_extension = full_path\sub 1, -6
                classpath = without_extension\gsub "/", "."
                classname = (classpath\match "%.%a+$")\sub 2
                --print classname
                file_object\write "    #{classname}: require \"#{classpath}\"\n"
    file_object\write "return Components"
    file_object\close!


build = ->
    generate_component_imports!
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

love = ->
    build!
    run_command "cd build && love ."


clean = ->
    run_command "rm -rf build game.love"
    run_command "rm -rf src/Components.moon"
    recursive_delete ".", {"/lib/", "lint_config%.lua", "main%.lua"}, ".*%.lua$"
    recursive_delete ".", {}, "luacov%..*%.out$"

lint = ->
    files = capture_command 'find . -type f -name "*.moon" | grep src'
    succ = true
    for line in magiclines files
        res = run_command "moonpick #{line}", true
        if not (res==0 or res==true)
            succ = false
    if not succ
        os.exit -1

install_dev = ->
    is_admin, _ = capture_command "id -u"
    print type is_admin
    if not is_admin == '0'
        print "This command must be run as root!"
        print "run sudo moon build.moon install_dev"
        os.exit -1
    print "Installing busted..."
    run_command "luarocks install busted"
    print "Installing ldoc"
    run_command "luarocks install ldoc"
    print "Installing luacov"
    run_command "luarocks install luacov"
    print "Installing moonpick"
    run_command "luarocks install moonpick"
    print "All dev tools are installed!"

runner = 
    :test
    :package
    :clean
    :lint
    :install_dev
    :love
runner[arg[1]]!