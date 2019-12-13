#!/bin/bash
BACKGROUND=~/.config/configs/bins/backgrounds/current.png

compton &
nm-applet &
fish -c mpd-listen &
feh --bg-fill $BACKGROUND
