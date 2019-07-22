function make_tex --description "Make me a tex buddy"
	if test (count $argv > /dev/null -eq 0); \
	or test (count $argv > /dev/null -gt 1)
		echo "Error: No name given."
		echo "Usage: make_tex texname"
		exit
	end

	if test -f ~/.config/configs/bins/templates/Report_Template.tex
		cp ~/.config/configs/bins/templates/Report_Template.tex $argv.tex
	end
end
