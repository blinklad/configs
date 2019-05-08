function mansplain --description 'Like man, but actually an expert'
	man -k . | dmenu -l 30 | awk '{print }' | xargs -r man -Tpdf | zathura -
end
