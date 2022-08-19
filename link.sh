#!/bin/bash

mkdir -p ~/trash

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

for i in $(seq 0 2 14); do
    src=${FILES[${i}]};
    dst=${FILES[$((i+1))]};
    echo "mv ${dst} ~/trash";
    echo "ln -s $(realpath ${src}) ${dst}";
done;

mv ~/.gdbinit ~/trash/
ln -s $(realpath gdbinit) ~/.gdbinit


