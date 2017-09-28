instance creation
waitForWindowsCommand: aCommand 
	^ ProcessWrapper new 
		startWithShellCommand: aCommand, '> C:\Users\Chris\log.txt 2>&1'; 
		waitForExit;
		yourself