testing
isCommandAvailable: aCommand
	 ^ Smalltalk os isWindows
			ifTrue: [ (ProcessWrapper new 
							useStderr;
							waitForExit;
							startWithShellCommand: aCommand; 
							yourself) stderrStream atEnd ]
			ifFalse: [ (OSProcess waitForCommand: aCommand) succeeded ]