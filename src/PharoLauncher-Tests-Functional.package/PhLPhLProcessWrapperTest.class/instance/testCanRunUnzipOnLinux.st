tests
testCanRunUnzipOnLinux
	| process |
	Smalltalk os isWindows ifTrue: [ ^ self ].
	process := PhDProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded