instance creation
command: aCommand 
	^ Smalltalk os isWindows
			ifTrue: [ self windowsCommand: aCommand ]
			ifFalse: [ OSProcess command: aCommand ]