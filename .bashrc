#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='[\W]\$ '

gccgtk () {
gcc `pkg-config --cflags gtk+-2.0` "$1" -o "$2" `pkg-config --libs gtk+-2.0`
}

hb () {
	HandBrakeCLI -i "$1" -o "$2"
}

alias sus="systemctl suspend"
alias date='date +%A" "%d" "%B" "%H:%M:%S'
alias sa="systemd-analyze"
alias ws="watch -n 0.5 sensors"
alias st="sudo turbostat"
alias winesync="sudo rm /etc/udev/rules.d/winesync.rules /etc/modules-load.d/winesync.conf /usr/include/linux/winesync.h"
alias rbf="systemctl reboot --firmware"
alias cdsteam="cd /home/bas/.local/share/Steam/steamapps/common"
alias lin="cd Downloads/linpack/LinpackXtreme-1.1.5/linpack-xtreme-1.1.5-amd64/"
alias zen="./run_stress_test_zen2+"
alias reflector="sudo reflector --latest 30 --protocol https --sort rate --age 8 -c Netherlands,Germany --save /etc/pacman.d/mirrorlist"
alias rmswap="rm ~/.cache/vim/swap/*"
alias hyper="./home/bas/.local/bin/hyprland"
alias ref="reflector --country Netherlands,Germany --protocol https --sort rate --age 12 --save /etc/pacman.d/mirrorlist"
