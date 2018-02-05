instance creation
waitForCommand: aCommand 
	^ self new
		process: ((Smalltalk os isWindows and: [ Smalltalk includesKey: #ProcessWrapper ])
			ifTrue: [ self waitForWindowsCommand: aCommand ]
			ifFalse: [ self waitForLinuxCommand: aCommand ]);
		yourself