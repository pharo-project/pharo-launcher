testing
isCommandAvailable: aCommand
	Smalltalk os isWindows
		ifTrue: [ Smalltalk
				at: #ProcessWrapper
				ifPresent: [ :processWrapperClass | 
					^ (processWrapperClass new
						useStderr;
						waitForExit;
						startWithShellCommand: aCommand;
						yourself) stderrStream atEnd ].
			^ false ].
	^ (OSProcess waitForCommand: aCommand) succeeded