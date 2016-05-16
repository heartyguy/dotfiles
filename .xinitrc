#!/bin/sh
# .xinitrc

# --- resources ---
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

# --- variables ---
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

# --- configurations ---
xset r rate 250 30
xsetroot -cursor_name left_ptr
urxvtd -q -o -f

# --- processes ---
compton --config ~/.compton.conf -b
feh --randomize --bg-fill -z ~/Dropbox/pictures/wallpapers/* &
dropboxd &
xscreensaver -no-splash &
syndaemon -i 0.2 -k &

# --- window manager ---
exec xmonad
