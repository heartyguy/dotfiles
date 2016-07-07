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
feh --randomize --bg-fill -z ~/Dropbox/pictures/wallpapers/*

case $1 in
  re)
    exit
    ;;
  duo)
    xrandr --output VGA1 --auto --right-of eDP1
    exit
    ;;
  sol)
    xrandr --auto
    exit
    ;;
  *)
    echo "wrong arguments. accepted: re|duo|sol"
    ;;
esac

# --- processes ---
compton --config ~/.compton.conf -b
dropboxd &
xscreensaver -no-splash &
syndaemon -i 0.2 -k &

# --- window manager ---
exec xmonad
