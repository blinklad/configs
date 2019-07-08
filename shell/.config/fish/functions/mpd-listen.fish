function mpd-listen --description 'Listens for UDP MPD audio streams'
	mkfifo /tmp/mpd.fifo # Make named pipe
	nohup mopidy &		 # Fork mdp
	while true
		yes \n | nc -lu 127.0.0.1 5555 > /tmp/mpd.fifo; 
	end
end
