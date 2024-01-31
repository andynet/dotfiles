#!/usr/local/bin/fish

if status is-interactive
    # Commands to run in interactive sessions can go here

    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba init' !!
    set -gx MAMBA_EXE "/home/balaz/.dotfiles/user/.local/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX "/home/balaz/.local/share/micromamba"
    $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
    # <<< mamba initialize <<<

    abbr --add mm micromamba
    abbr --add mma micromamba activate
    abbr --add mmd micromamba deactivate
    abbr --add conda micromamba
end

