#! /bin/sh
# Generic compiler script. WIP. 

file=$(readlink -f "$1")
dir=($dirname "$file")

# Regex checks file extension and executes commands
case "$file" in 
		*\.tex) pdflatex -interaction nonstopmode -output-directory $dir -no-file-line-error "$file" ;;
		*\.java) javac "$file" ;;
esac
