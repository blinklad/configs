#! /bin/sh
# Generic compiler script. WIP. 

file=$(readlink -f "$1")
dir=($dirname "$file")

# Regex checks file extension and executes commands
case "$file" in 
		*\.tex) pdflatex "$file" ;;
		*\.java) javac "$file" ;;
esac
