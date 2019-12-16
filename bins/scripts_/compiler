#! /bin/sh
# Generic compiler script.

base="${file%.*}"
file=$(readlink -f "$1")
dir=($dirname "$file")

cd "$dir" || exit
# thanks https://github.com/LukeSmithxyz/voidrice/
textype() { \
	command="pdflatex"
	( sed 5q "$file" | grep -i -q 'xelatex' ) && command="xelatex"
	$command --output-directory="$dir" "$base" &&
	$command --output-directory="$dir" "$base"
	}

case "$file" in 
        *\.c) cc "$file" -o "$base" && "$base" ;;
		*\.tex) textype "$file" ;;
		*\.java) javac "$file" ;;
esac
