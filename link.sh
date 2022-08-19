#!/bin/bash
set -euxo pipefail

FILES=(
    bash_aliases            ~/.bash_aliases
    condarc                 ~/.condarc
    gdbinit                 ~/.gdbinit
    profile                 ~/.profile
    ssh_config              ~/.ssh/config
    bashrc                  ~/.bashrc
    config_user-dirs.dirs   ~/.config/user-dirs.dirs
    taskrc                  ~/.taskrc
)

mkdir -p ~/trash
for i in $(seq 0 2 14); do
    src=${FILES[${i}]};
    dst=${FILES[$((i+1))]};
    mv ${dst} ~/trash;
    ln -s $(realpath ${src}) ${dst};
done;

# mkdir -p ~/.config/nvim/autoload
# curl -Lo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
