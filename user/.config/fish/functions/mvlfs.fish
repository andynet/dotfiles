function mvlfs
    for arg in $argv
        set path $(realpath "$arg")
        set new_name $(echo "$path" | string split '/' | tail -n +4 | string join '_')
        set destination "$HOME/lfs/$new_name"
        mv "$path" "$destination"
        ln -s "$destination" "$path"
    end
end
