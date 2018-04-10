actions
removeFromStartupList
	[ PhLStartupManager removeFromStartupList: self ]
		on: NotFound 
		do: [ :e | "Not there, just ignore!" ]