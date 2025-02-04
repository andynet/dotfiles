function delink
    for arg in $argv
        set path $(realpath "$arg")
        rm "$arg"
        cp "$path" "$arg"
        echo "$arg <- $path"
        echo "$arg <- $path" >> delinked.txt
    end
end
