function make_notes -d "Compiles markdown notes to anki flashcards"
	set note_dir ~/Dropbox/vimwiki/cards/
	set subjects KIT102-cards KIT103-cards KIT201-cards KIT206-cards

	for subject in $subjects
		command python3 ~/.local/lib/python3.7/site-packages/ankdown.py -r $note_dir/$subject
	end
end
