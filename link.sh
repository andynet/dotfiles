#!/bin/bash
set -euxo pipefail

FILES=(
    bashrc          ~/.bashrc
    condarc         ~/.condarc
    i3_config       ~/.config/i3/config
    i3blocks.conf   ~/.config/i3/i3blocks.conf
    init.vim        ~/.config/nvim/init.vim
    snakemake.vim   ~/.config/nvim/snakemake.vim
    user-dirs       ~/.config/user-dirs.dirs
    gdbinit         ~/.gdbinit
    profile         ~/.profile
    ssh_config      ~/.ssh/config
    taskrc          ~/.taskrc
    xinitrc         ~/.xinitrc
)

mkdir -p ~/trash
for i in $(seq 1 2 ${#FILES[@]}); do
    src=${FILES[$((i-1))]};
    dst=${FILES[${i}]};
    if [[ -e ${dst} ]]; then mv ${dst} ~/trash/${src}; fi;
    mkdir -p $(dirname ${dst})
    ln -s $(realpath ${src}) ${dst};
done;

rm -rf ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

mkdir -p ~/.config/nvim/autoload
if [[ ! -e ~/.config/nvim/autoload/plug.vim ]]; then
    curl -Lo ~/.config/nvim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
