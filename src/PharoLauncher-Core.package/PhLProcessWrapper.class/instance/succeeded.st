testing
succeeded
	^ Smalltalk os isWindows
		ifTrue: [ process isRunning not and: [ process exitCode == 0 ] ] 
		ifFalse: [ process succeeded ]