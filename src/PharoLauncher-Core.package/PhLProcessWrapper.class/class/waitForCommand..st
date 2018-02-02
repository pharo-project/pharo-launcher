instance creation
waitForCommand: aCommand 
	^ self new
		process: (Smalltalk os isWindows
			ifTrue: [ self waitForWindowsCommand: aCommand ]
			ifFalse: [ self waitForLinuxCommand: aCommand ]);
		yourself