*PharoLauncher-Tests-Functional
testCanRunUnzipOnLinux
	| process |
	Smalltalk os isWindows ifTrue: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded