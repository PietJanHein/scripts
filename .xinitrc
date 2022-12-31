#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

systemd-analyze | grep Startup | cut -d ' ' -f 4 >> startuptime
picom -CG --no-fading-openclose &
lxpolkit &
nitrogen --restore &
copyq &
flameshot &
~/scripts/panelfilling &
xset s off -dpms
#xrandr --output DisplayPort-2 --right-of HDMI-A-0 --primary --set 
#xrandr --output HDMI-A-0 --left-of DisplayPort-2
xrandr --output HDMI-A-0 --off

xset r rate 155 70
#exec startxfce4
#exec startplasma-x11
exec dwm
