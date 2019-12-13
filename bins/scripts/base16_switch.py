import os
THEME_DIR = r"~/.config/.themes/base16-"

arg = "" # TODO
update_fish = lambda x: os.system("{}", arg)

# These lines are used to find colour palette inclusion unambigiously per key,
# whether inline or using inclusion / import logic
# 2-tuple is start and end tokens. It isn't pretty. 
targets = {"tmux" : r"#include\"/home/blinklad/.config/.themes/base16",
          "alacritty" : r"colors:\n\t# Default colors"
          "termite" : (r"[colors]", r"["),
          "lightline" :
          }

themes = {"tmux" : r"source-file ~/.config/.themes/base16-tmux}
