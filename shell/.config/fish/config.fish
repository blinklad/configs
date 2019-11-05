# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# General programs                                                            # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
abbr -a e nvim
abbr -a pac 'sudo pacman -Syu'
abbr -a c cargo
abbr -a r 'cargo run'
abbr -a ct 'cargo test'
abbr -a m make
abbr -a mu 'ncmpcpp'
abbr -a ankdown 'python3 ~/.local/lib/python3.7/site-packages/ankdown/ankdown.py'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Git																	  # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
abbr -a g git
abbr -a gp 'git commit && git push'
abbr -a ga 'git add -p'
abbr -a gaa 'git add .'
abbr -a gs 'git status' # aliases ghostscript

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Configs																	  # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

abbr -a cv 'nvim ~/.vimrc'
abbr -a ci3 'nvim ~/.config/i3/config'
abbr -a ct 'nvim ~/.config/i3/config'
abbr -a cw "nvim ~/.vimwiki/index.md"
abbr -a cf 'nvim ~/.config/configs/shell/.config/fish/config.fish'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Directory																	  # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
abbr -a gc ~/.config/configs/
abbr -a gu ~/Uni/
abbr -a gw ~/.vimwiki
abbr -a gd ~/dev/

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Fzf																		  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Directory hopping
abbr -a fu 'builtin cd ~/Uni/ && fzf-cd-widget'
abbr -a fw 'builtin cd ~/.vimwiki/ && fzf-cd-widget'
abbr -a fi 'builtin cd $PICTURES && fzf-cd-widget'

# Changing files
abbr -a cu 'builtin cd ~/Uni/; nvim (fzf)'
abbr -a cde 'builtin cd ~/dev/; nvim (fzf)' 
abbr -a cr 'builtin cd (git rev-parse --show-toplevel); nvim (find . | fzf)'

# Opening files
abbr -a ou 'builtin cd ~/Uni; xdg-open (fzf)'
abbr -a ow 'builtin cd ~/.vimwiki; xdg-open (fzf)'
abbr -a oc 'builtin cd ~/.config/; nvim (find . | fzf)' # Hack for hidden files

complete --command yay --wraps pacman
set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/bin /bin ~/.cargo/bin ~/.local/bin/

if command -v yay > /dev/null
	abbr -a p 'yay'
	abbr -a up 'yay -Syu'
else
	abbr -a p 'sudo pacman'
	abbr -a up 'sudo pacman -Syu'
end

if command -v exa > /dev/null
	abbr -a l 'exa -l'
	abbr -a ls 'exa'
	abbr -a lll 'exa -la'
	abbr -a lh 'exa -lh'
	abbr -a lha 'exa -lha'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

if command -v rg > /dev/null
	abbr -a grep 'rg'
end

if command -v zathura > /dev/null
	abbr -a z 'zathura --fork'
end

if command -v bat > /dev/null
	abbr -a cat 'bat'
end

if [ -e /usr/share/fish/functions/fzf_key_bindings.fish ]; and status --is-interactive
	source /usr/share/fish/functions/fzf_key_bindings.fish
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

function ssh
	switch $argv[1]
	case "*.amazonaws.com"
		env TERM=xterm /usr/bin/ssh $argv
	case "ubuntu@"
		env TERM=xterm /usr/bin/ssh $argv
	case "*"
		/usr/bin/ssh $argv
	end
end

function apass
	if test (count $argv) -ne 1
		pass $argv
		return
	end

	asend (pass $argv[1] | head -n1)
end

function asend
	if test (count $argv) -ne 1
		echo "No argument given"
		return
	end

	adb shell input text (echo $argv[1] | sed -e 's/ /%s/g' -e 's/\([[()<>{}$|;&*\\~"\'`]\)/\\\\\1/g')
end

function limit
	numactl -C 0,1,2 $argv
end

function remote_alacritty
	# https://gist.github.com/costis/5135502
	set fn (mktemp)
	infocmp alacritty > $fn
	scp $fn $argv[1]":alacritty.ti"
	ssh $argv[1] tic "alacritty.ti"
	ssh $argv[1] rm "alacritty.ti"
end

function remarkable
	if test (count $argv) -lt 1
		echo "No files given"
		return
	end

	ip addr show up to 10.11.99.0/29 | grep enp0s20f0u2 >/dev/null
	if test $status -ne 0
		# not yet connected
		echo "Connecting to reMarkable internal network"
		sudo dhcpcd enp0s20f0u2
	end
	for f in $argv
		echo "-> uploading $f"
		curl --form "file=@\""$f"\"" http://10.11.99.1/upload
		echo
	end
end

function athena
	env SSHPASS=(pass www/mit) sshpass -e ssh athena $argv
end

# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# 'Environment' variables
set -x EDITOR nvim
set -x VISUAL nvim
set -x DOTNET_ROOT /opt/dotnet
set -x GTK2_RC_FILES ~/.gtkrc-2.0
set -x PYTHON_LOCAL /home/blinklad/.local/lib/python3.7/site-packages/
set -x BACKGROUNDS /home/blinklad/documents/pictures/backgrounds/
set -x PICTURES /home/blinklad/documents/pictures/
set -x SCRIPTS /home/blinklad/.scripts/

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# For RLS
# https://github.com/fish-shell/fish-shell/issues/2456
setenv LD_LIBRARY_PATH (rustc +nightly --print sysroot)"/lib:$LD_LIBRARY_PATH"
setenv RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS "--height 25% --preview 'bat --style=numbers --color=always {}'"
set -U FZF_TMUX 1
set -U FZF_ENABLE_OPEN_PREVIEW 1

setenv OS_USERNAME harveyem@utas.edu.au 

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

fish_ssh_agent # I like SSH keys

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/.themes/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and exa -l
    else
        builtin cd ~; and exa -l
    end
end

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	bind \cl 'fish_clear; fish_prompt'
	bind \cf 'fzf-cd-widget'

	if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -ne '\e[2mevan'

	set_color brblack
	echo -n ':'
	set_color yellow

	if [ $PWD = $HOME ]
		echo -ne '\e[2mhome'
	else
		echo -n (basename $PWD)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -ne '\e[2mλ '
	set_color normal
end

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;94m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;94m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;94m"$0"\\\\e[0m"}')
	echo -e " \\e[1mDisk usage:\\e[0m"
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper|nvme)' | \
		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
		paste -sd ''\
	)
	echo

	echo -e " \\e[1mNetwork:\\e[0m"
	echo
	# http://tdt.rocks/linux_network_interface_naming.html
	echo -ne (\
		ip addr show up scope global | \
			grep -E ': <|inet' | \
			sed \
				-e 's/^[[:digit:]]\+: //' \
				-e 's/: <.*//' \
				-e 's/.*inet[[:digit:]]* //' \
				-e 's/\/.*//'| \
			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
			sort | \
			column -t -R1 | \
			# public addresses are underlined for visibility \
			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
			# private addresses are not \
			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
			# unknown interfaces are cyan \
			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
			# ethernet interfaces are normal \
			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
			# wireless interfaces are purple \
			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
			# wwan interfaces are yellow \
			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
			sed 's/$/\\\e[0m/' | \
			sed 's/^/\t/' \
		)
	echo

	set r (random 0 100)
	if [ $r -lt 5 ] # only occasionally show backlog (5%)
		echo -e " \e[1mBacklog\e[0;32m"
		set_color blue
		echo "  [project] <description>"
		echo
	end

	set_color normal
	echo -e " \e[1mTODOs\e[0;32m"
	if [ $r -lt 10 ]
		# unimportant, so show rarely
		set_color cyan
		# echo "  [project] <description>"
	end
	if [ $r -lt 25 ]
		# back-of-my-mind, so show occasionally
		set_color green
		# echo "  [project] <description>"
	end
	if [ $r -lt 50 ]
		# upcoming, so prompt regularly
		set_color yellow
		# echo "  [project] <description>"
	end

	# urgent, so prompt always
	set_color red
	# echo "  [project] <description>"

	echo

	if test -s ~/todo
		set_color normal 555 brblack
		bat ~/todo | sed 's/^/ /'
		echo
	end

	set_color normal
end

# Anaconda likes to trample over root packages - get around this
# https://github.com/gtrichards/PHYS_T480_F18/issues/1
source "/home/blinklad/dev/python/anaconda3/anaconda3/etc/fish/conf.d/conda.fish"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# eval (eval /home/blinklad/dev/python/anaconda3/anaconda3/bin/conda "shell.fish" "hook" $argv)
# # <<< conda initialize <<<

