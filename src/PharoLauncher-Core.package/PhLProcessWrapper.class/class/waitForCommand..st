execution - public
waitForCommand: aCommand
	| encodedCommand |
	encodedCommand := self encode: aCommand.
	^ self new
		process: ((Smalltalk os isWindows and: [ Smalltalk includesKey: #ProcessWrapper ])
			ifTrue: [ self waitForWindowsCommand: encodedCommand ]
			ifFalse: [ self waitForLinuxCommand: encodedCommand ]);
		yourself