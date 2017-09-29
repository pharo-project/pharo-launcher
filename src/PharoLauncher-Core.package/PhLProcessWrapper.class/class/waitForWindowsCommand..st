instance creation
waitForWindowsCommand: aCommand 
	^ ProcessWrapper new 
		startWithShellCommand: aCommand; 
		waitForExit;
		yourself