Class {
	#name : #PhLPhLProcessWrapperTest,
	#superclass : #TestCase,
	#category : 'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLPhLProcessWrapperTest >> testCanRunUnzipOnLinux [
	| process |
	Smalltalk os isWindows ifTrue: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded
]

{ #category : #tests }
PhLPhLProcessWrapperTest >> testCanRunUnzipOnWindows [
	| process |
	Smalltalk os isWindows ifFalse: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded
]
