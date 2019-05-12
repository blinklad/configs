# Non-POSIX dependencies: 
# dmenu
# zathura
# zathura-pdf-mupdf
function mansplain --description 'Think you\'re an expert? Mansplain knows better.'
	set options 30 # Arbitrary, the # of options for dmenu to show at a time
	man -k . |\
	dmenu -l $options |\
	awk '{print $1}' |\
	xargs -r man -Tpdf |\
	zathura -
end
