instance creation
windowsCommand: aCommand
	^ (Smalltalk at: #ProcessWrapper) new
		startWithShellCommand: aCommand;
		yourself