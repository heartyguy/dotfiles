#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto


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


# variables

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk


feh --bg-fill -z ~/pictures/wallpapers &
xset r rate 250 30
xsetroot -cursor_name left_ptr


exec xmonad
