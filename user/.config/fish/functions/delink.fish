function delink
    for arg in $argv
        set path $(realpath "$arg")
        rm "$arg"
        cp "$path" "$arg"
    end
end
