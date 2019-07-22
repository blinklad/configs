function purge_dos -d "Remove archaic DOS characters from files"
	find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix 
end
