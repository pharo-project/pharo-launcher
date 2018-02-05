instance creation
waitForWindowsCommand: aCommand
	^ (Smalltalk at: #ProcessWrapper) new
		startWithShellCommand: aCommand;
		waitForExit;
		yourself