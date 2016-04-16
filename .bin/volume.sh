#!/bin/sh

vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($5 == "off") { print "MM" } else { print $2/10 }}' | head -n 1)
bar=${vol%.*}

case $bar in
  0)    bar='-----' ;;
  1|2)  bar=')----' ;;
  3|4)  bar='))---' ;;
  5|6)  bar=')))--' ;;
  7|8)  bar='))))-' ;;
  9|10) bar=')))))' ;;
  *)    bar='--!--' ;;
esac

echo $bar

exit 0
