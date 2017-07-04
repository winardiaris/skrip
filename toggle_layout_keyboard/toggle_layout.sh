#!/bin/bash

function EXEC() {
  CURRENT="`setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}'`"
}

EXEC
if [ "$CURRENT" == "us" ]; then
  setxkbmap us colemak
else
  setxkbmap us
fi
EXEC
notify-send -t 1000 "System Message" "Keyboard layout changed to: ${CURRENT}"
