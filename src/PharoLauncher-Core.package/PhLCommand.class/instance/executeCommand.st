action
executeCommand
	[ self execute ]
		on: PhLCommandCancellation
		do: [ :ex | "Do nothing - user has cancelled the command" ].