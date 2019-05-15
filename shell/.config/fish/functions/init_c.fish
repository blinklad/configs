function init_c --description 'Makes an empty c directory, including a makefile and blank README, and then initialises a git repo.'
	if test (count $argv > /dev/null -eq 0); \
	or test (count $argv > /dev/null -gt 1)
		echo "Error: Incorrect or no directory name given."
		echo "Usage: init-c dirname"
		exit
	end
	set make_file_location "/home/blinklad/.config/configs/bins/Makefile"
	set directories include src bin obj tests
	set empty force_empty_dir

	command mkdir $argv
	for directory in $directories
		mkdir $argv/$directory
		echo "Force empty directory" > $argv/$directory/$empty
	end

	if test $status
		command cp $make_file_location $argv/
		command git init $argv/
	else 
		echo "Error making directories."
	end
end
