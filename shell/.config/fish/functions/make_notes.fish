function make_notes -d "Compiles markdown notes to anki flashcards"
	set note_dir ~/Dropbox/vimwiki/
	set subjects KIT102 KIT103 KIT201 KIT206

	for subject in $subjects
		if test ($note_dir/$subject/cards.md)
			command python3 ~/.local/lib/python3.7/site-packages/ankdown.py -r $note_dir/$subject
end
