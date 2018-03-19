instance creation
waitForWindowsCommand: commandString
	| process success |
	process := (Smalltalk at: #ProcessWrapper) new.
	success := process startWithShellCommand: commandString.
	success ifFalse: [
		self error: 'command ', commandString ,' failed' ].

	success := process waitForExit.
	success ifFalse: [
		self error: 'command ', commandString ,' failed' ].
	
	process exitCode = 0 ifFalse: [
		self error: 'command ', commandString ,' failed' ].

	^ process