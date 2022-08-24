#!/bin/bash
set -euxo pipefail

FILES=(
    profile         ~/.profile
    bashrc          ~/.bashrc
    xinitrc         ~/.xinitrc
    ssh_config      ~/.ssh/config
    user-dirs       ~/.config/user-dirs.dirs
    condarc         ~/.config/conda/condarc
    i3_config       ~/.config/i3/config
    i3blocks.conf   ~/.config/i3/i3blocks.conf
    init.vim        ~/.config/nvim/init.vim
    snakemake.vim   ~/.config/nvim/snakemake.vim
    gdbinit         ~/.config/gdb/gdbinit
    taskrc          ~/.config/task/taskrc
)

mkdir -p ~/data ~/downloads ~/projects ~/tools ~/tmp
rm -rf ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

for i in $(seq 1 2 ${#FILES[@]}); do
    src=${FILES[$((i-1))]};
    dst=${FILES[${i}]};
    if [[ -e ${dst} ]]; then mv ${dst} ~/tmp/${src}; fi;
    mkdir -p $(dirname ${dst})
    ln -s $(realpath ${src}) ${dst};
done;


mkdir -p ~/.config/nvim/autoload
if [[ ! -e ~/.config/nvim/autoload/plug.vim ]]; then
    curl -Lo ~/.config/nvim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

