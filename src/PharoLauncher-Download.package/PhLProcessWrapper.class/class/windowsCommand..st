instance creation
windowsCommand: aCommand
	" Run the command in the background so that the process returns immediately. 
	It prevents the process to be finalized by ProcessWrapper before the image beiing launched!.
	More information on START: https://ss64.com/nt/start.html"
	^ (Smalltalk at: #ProcessWrapper) new
		startWithShellCommand: 'START /B ', aCommand;
		yourself