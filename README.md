# dotfiles

https://wiki.archlinux.org/title/XDG_Base_Directory

to list shell variables
`( set -o posix ; set ) | less`
to list env variables
`env | less`

`sudo pacman -S terminus-font`

this is what happens after init script:
`https://wiki.archlinux.org/title/Arch_boot_process#Late_userspace`

`https://wiki.archlinux.org/title/Xinit#Switching_between_desktop_environments/window_managers`

this lists a subtree of a process:
`ps --forest $(ps -e --no-header -o pid,ppid|awk -vp=1271 'function r(s){print s;s=a[s];while(s){sub(",","",s);t=s;sub(",.*","",t);sub("[0-9]+","",s);r(t)}}{a[$2]=a[$2]","$1}END{r(p)}')`
