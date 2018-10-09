execution - public
command: aCommand

	| encodedCommand |
	encodedCommand := self encode: aCommand.
	^ Smalltalk os isWindows
			ifTrue: [ self windowsCommand: encodedCommand ]
			ifFalse: [ OSProcess command: encodedCommand ]