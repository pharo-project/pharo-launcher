instance creation
waitForLinuxCommand: aCommand 
	^ OSSUnixSubprocess new 
		shellCommand: aCommand;
		runAndWait;
		yourself