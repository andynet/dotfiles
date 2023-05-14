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