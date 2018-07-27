tests
testCanRunUnzipOnWindows
	| process |
	Smalltalk os isWindows ifFalse: [ ^ self ].
	process := PhDProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded