action
launchCommandWith: vmCommand useSettings: usePharoSettings
	| imagePath vmDirectoryPath command basicCommand |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := String
		streamContents: [ :cmd | 
			cmd << 'cd ' << file parent pathString surroundedByDoubleQuotes << ' && '.
			Smalltalk os isUnix
				ifTrue: [ cmd << (self exportLDLibraryPathCommandWith: vmDirectoryPath) << ' && export SQUEAK_PLUGINS="" && ' ].
			cmd << vmCommand surroundedByDoubleQuotes << ' ' << imagePath surroundedByDoubleQuotes.
			usePharoSettings ifFalse: [ cmd << ' --no-default-preferences' ] ].
	basicCommand := self class launchInALoginShell
		ifTrue: [ Smalltalk os isWindows
				ifTrue: [ 'cmd /C ' , command ]
				ifFalse: [ 'bash -l -c ''' , command , '''' ] ]
		ifFalse: [ command ].
	^ basicCommand