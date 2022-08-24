echo "Loading profile..."

# remove env variables except XDG_RUNTIME_DIR and HOME
for var in $(env | cut -f1 -d"="); do
    case $var in
        XDG_RUNTIME_DIR);;
        HOME);;
        TERM);;
        LANG);;
        *) unset $var;;
    esac;
done;

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"

# XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config       # user-specific configurations (analogous to /etc)
export XDG_CACHE_HOME=$HOME/.cache         # user-specific non-essential data (analogous to /var/cache)
export XDG_DATA_HOME=$HOME/.local/share    # user-specific data (analogous to /usr/share)
export XDG_STATE_HOME=$HOME/.local/state   # user-specific state files (analogous to /var/lib)

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi

