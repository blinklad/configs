function restore_layouts -d "fish package manager"
	set workspaces = web nvim util misc
	for workspace in $workspaces
		command python /usr/bin/i3-resurrect restore -w $workspace
	end
end
