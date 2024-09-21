#!/bin/sh

# https://wiki.archlinux.org/title/Environment_variables
export XDG_CONFIG_HOME="$HOME/.config"       # user-specific configuration
export XDG_CACHE_HOME="$HOME/.cache"         # user-specific non-essential data
export XDG_DATA_HOME="$HOME/.local/share"    # user-specific data files (analogous to /usr/share)
export XDG_STATE_HOME="$HOME/.local/state"   # user-specific state files (analogous to /var/lib)

export XINITRC="$XDG_CONFIG_HOME/xinitrc"
export XAUTHORITY="$XDG_STATE_HOME/Xauthority"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# set use of local bins, c headers, and libs
export PATH="$HOME/.local/bin:$PATH"
export C_INCLUDE_PATH="$HOME/.local/include"
export LIBRARY_PATH="$LIBRARY_PATH:$HOME/.local/lib"

export LC_COLLATE="C"

export EDITOR="nvim"
export BROWSER="firefox"  # use qutebrowser?

export JDK_JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

journalctl -p 3 -b

[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
# export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
# export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
# export GRB_LICENSE_FILE="/home/balaz/.config/gurobi.lic"
# export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
# export MANPATH="$HOME/.local/texmf/texmf-dist/doc/man:$MANPATH"
# -Dsun.java2d.uiScale=2
# export PATH="$HOME/.local/bin:$HOME/.local/texmf/bin/x86_64-linux:$PATH"
# export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
# export LIBVIRT_DEFAULT_URI="qemu:///system"


