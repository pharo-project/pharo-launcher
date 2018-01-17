action
launchCommandWith: vmCommand
	| imagePath vmDirectoryPath command |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := String
		streamContents: [ :cmd | 
			cmd << 'cd ' << file parent pathString surroundedByDoubleQuotes << ' && '.
			Smalltalk os isUnix
				ifTrue: [ cmd << (self exportLDLibraryPathCommandWith: vmDirectoryPath) << ' && export SQUEAK_PLUGINS="" && ' ].
			cmd << vmCommand surroundedByDoubleQuotes << ' ' << imagePath surroundedByDoubleQuotes ].
	^ self class launchInALoginShell
		ifTrue: [ Smalltalk os isUnix
				ifTrue: [ 'bash -l -c ''' , command , '''' ]
				ifFalse: [ 'cmd /C ' , command ] ]
		ifFalse: [ command ]