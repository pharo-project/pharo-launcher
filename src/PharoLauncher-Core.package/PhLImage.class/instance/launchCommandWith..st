action
launchCommandWith: vmCommand
	| imagePath vmDirectoryPath |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	^ String streamContents: [:command | 
		command << 'cd ' << file parent pathString surroundedByDoubleQuotes << ' && '.
		Smalltalk os isUnix
			ifTrue: [ command 
							<< (self exportLDLibraryPathCommandWith: vmDirectoryPath)
							<< ' && export SQUEAK_PLUGINS="" && ' ].
		command 
			<< vmCommand surroundedByDoubleQuotes << ' ' << imagePath surroundedByDoubleQuotes.
		].

