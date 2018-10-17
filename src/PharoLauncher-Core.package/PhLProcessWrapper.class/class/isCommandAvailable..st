testing
isCommandAvailable: aCommand
	| encodedCommand |
	encodedCommand := self encode: aCommand.
	
	Smalltalk os isWindows
		ifTrue: [ Smalltalk
				at: #ProcessWrapper
				ifPresent: [ :processWrapperClass | 
					^ (processWrapperClass new
						useStderr;
						waitForExit;
						startWithShellCommand: encodedCommand;
						yourself) stderrStream atEnd ].
			^ false ].
	^ (OSProcess waitForCommand: encodedCommand) succeeded