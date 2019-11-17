lfs = require "lfs"

run_command = (cmd, ignore = false) ->
    result = os.execute cmd
    --print "command \""..cmd.."\" returned "..tostring(ret_code)
    if not (result==0 or result==true or ignore)
        os.exit -1

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
    recursive_delete ".", {"/lib/", "lint_config%.lua"}, ".*%.lua$"
    recursive_delete ".", {}, "luacov%..*%.out$"

lint = ->
    run_command "moonc -l ."

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
    print "All dev tools are installed!"


runner = 
    :test
    :package
    :clean
    :lint
    :install_dev
runner[arg[1]]!