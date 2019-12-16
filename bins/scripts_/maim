#!/usr/bin/env sh

# This is bound to Shift+PrintScreen by default, requires maim. It lets you
# choose the kind of screenshot to take, including copying the image or even
# highlighting an area to copy. scrotcucks on suicidewatch right now.
# TODO compton should ignore maim
# thanks https://github.com/LukeSmithxyz/voidrice
SCREENSHOTS=~/documents/pictures/screenshot

case "$(printf "a selected area (copy)\\na selected area (save)\\ncurrent window (copy)\\ncurrent window (save)\\nfull screen (copy)\\nfull screen (save)\\n" | dmenu -l 6 -i -p "Screenshot which area?")" in
	"a selected area (copy)") maim -s pic-selected-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"a selected area (save)") maim -s $SCREENSHOTS/pic-selected-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"current window (copy)") maim -i "$(xdotool getactivewindow)" pic-window-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"current window (save)") maim -i "$(xdotool getactivewindow)" $SCREENSHOTS/pic-window-"$(date '+%y%m%d-%H%M-%S').png" ~/documents/pictures/screenshot/ ;;
	"full screen (copy)") maim | xclip -selection clipboard -t image/png ;;
	"full screen (save)") maim $SCREENSHOTS/pic-fullscreen-"$(date '+%y%m%d-%H%M-%S').png"  ;;
esac
