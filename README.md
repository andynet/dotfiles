#Dotfiles
---
## install
```
git clone https://github.com/andynet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow -v user # apply user configuration

stow -vt / system # apply system configuration
```

## [nvidia](https://www.youtube.com/watch?v=iYWzMvlj2RQ)
Some combination of following works:
```
sudo pacman -S nvidia nvidia-settings opencl-nvidia xf86-video-amdgpu

sudo nvim /etc/mkinitcpio.conf
sudo mkinitcpio -P

git clone https://aur.archlinux.org/optimus-manager.git
cd optimus-manager/
makepkg -s
makepkg -i

prime-offload
optimus-manager --print-mode
optimus-manager --switch hybrid
sudo prime-switch
```

## mamba
```
curl micro.mamba.pm/install.sh > install.sh
bash install.sh
```

## rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## latex
#### install
```
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xvzf install-tl-unx.tar.gz
cd install-tl-*
perl install-tl --texdir=~/.local/texmf --texuserdir=~/.local/texmf --scheme scheme-basic

PATH=~/.local/texmf/bin/x86_64-linux:$PATH
MANPATH=~/.local/texmf/texmf-dist/doc/man:$MANPATH
```
#### install packages
```
tlmgr install latexmk texliveonfly biblatex cm-super biber microtype
tlmgr search --file <file> --global
tlmgr install <pkg>
tlmgr list --only-installed --data name
```
#### install custom .sty files
```
kpsewhich -var-value=TEXMFHOME
cd <there>
mkdir -p tex/latex
cd tex/latex/
cp <file.sty> .
mktexlsr .
kpsewhich <file.sty>
```

## gurobi
```
grbgetkey <key>
```
