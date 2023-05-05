# Install arch linux
* check iso and dd to USB
* boot USB
* connect to network
```
iwctl
device list
station ${device} scan
station ${device} get-networks
station ${device} connect ${ssid}
ping archlinux.org
```
* format and mount disks
```
fdisk -l
fdisk /dev/${disk}
g -> n +512M -> n -> w

lsblk -f
mkfs.fat -F 32 /dev/${disk}1
mkfs.ext4 /dev/${disk}2

mount /dev/${disk}2 /mnt
mount --mkdir /dev/${disk}1 /mnt/boot
```
* install
```
pacstrap -K /mnt 
    base linux linux-firmware
    grub efibootmgr intel-ucode
    sudo nano man-db man-pages
    networkmanager firefox
    alsa-utils ?alsa-firmware ?sof-firmware ?alsa-ucm-conf 
    xorg xorg-xinit i3-wm ?xfce4
    terminus-font

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```
* configure basics
```
ln -sf /usr/share/zoneinfo/CET /etc/localtime
hwclock --systohc

nano /etc/locale.gen
nano /etc/locale.conf   # LANG=en_US.UTF-8
nano /etc/vconsole.conf # FONT=ter-122n # ls /usr/share/kbd/consolefonts/
locale-gen

nano /etc/hostname      # <hostname>
systemctl enable NetworkManager.service

passwd
EDITOR=nano visudo
useradd -m -g wheel ${user}
passwd ${user}
passwd -l root
```
* reboot
```
exit
reboot
```
* continue with readme
