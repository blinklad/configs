function md_preview --description 'Like ctrl-l, but pushes fish_greeter back to the prompt.'
	file $1 | grep -iq latex && pdflatex -output-directory /tmp $1

	# markdown
	basename $1 | grep -iq "\.md$" && pandoc --template=$PANDOC_TEMPLATES/default.latex -s $1 -o /tmp/${fn}

	wid=$(xdotool search --name "${fn}")

	if (test -z "$wid")
		setsid zathura-tabbed /tmp/${fn}
		xdotool search --name "${fn}" windowactivate
	else
		xdotool key --window $wid 'R'
	done
done
