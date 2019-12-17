function init_c --description 'Makes an empty c directory, including a makefile and blank README, and then initialises a git repo.'
	set TEMPLATE_PATH "/home/blinklad/.config/configs/bins/templates/c-template/"
	# Sanity check
	if test (count $argv > /dev/null -eq 0); \
	or test (count $argv > /dev/null -gt 1)
		echo "Error: Incorrect or no directory name given."
		echo "Usage: init-c dirname"
		exit
	end

	# TODO Test library
	set make_file_location "$TEMPLATE_PATH/Makefile"
	set driver_file_location "$TEMPLATE_PATH/main.c"
	set main_header "/** Driver file for $argv. */"
	set spec_header "/** Specification for $argv. */"

	set directories include src bin obj tests
	set empty force_empty_dir

	command mkdir $argv
	for directory in $directories
		mkdir $argv/$directory
		echo "Force empty directory" > $argv/$directory/$empty

		if [ "$directory" = "src" ]
			command echo $main_header >> $argv/$directory/main.c
			command echo "#include \"$argv.h\"" >> $argv/$directory/main.c
			command cat $driver_file_location >> $argv/$directory/main.c
		end

		if [ "$directory" = "include" ] 
			command echo $spec_header >> $argv/$directory/$argv.h
		end
	end

	if test $status
		command cp $make_file_location $argv/
		command git init $argv/
	else 
		echo "Error making directories."
	end
end
