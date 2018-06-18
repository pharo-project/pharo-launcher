instance creation
windowsCommand: aCommand 
	^ ProcessWrapper new 
		startWithShellCommand: aCommand;
		yourself