tests
testCanRunUnzipOnWindows
	| process |
	Smalltalk os isWindows ifFalse: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded