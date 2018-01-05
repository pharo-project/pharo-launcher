action
launchCommandWith: vmCommand
	| imagePath vmDirectoryPath command |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := String streamContents: [:cmd |
		cmd << 'cd ' << file parent pathString surroundedByDoubleQuotes << ' && '.
		Smalltalk os isUnix
			ifTrue: [ cmd 
							<< (self exportLDLibraryPathCommandWith: vmDirectoryPath)
							<< ' && export SQUEAK_PLUGINS="" && ' ].
		cmd 
			<< vmCommand surroundedByDoubleQuotes << ' ' << imagePath surroundedByDoubleQuotes.
		].
	^	self class launchInAShell
			ifTrue: [ 'bash -c ''' , command , ''''. ('bash -c ''' , command , '''') inspect ]
			ifFalse: [ command ]