Class {
	#name : #PhLProcessWrapperTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunUnzipOnLinux [
	| process |
	Smalltalk os isWindows ifTrue: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded
]

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunUnzipOnWindows [
	| process |
	Smalltalk os isWindows ifFalse: [ ^ self ].
	process := PhLProcessWrapper waitForCommand: 'unzip --help'.
	self assert: process succeeded
]
