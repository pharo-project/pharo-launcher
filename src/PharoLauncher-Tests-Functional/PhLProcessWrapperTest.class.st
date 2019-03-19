Class {
	#name : #PhLProcessWrapperTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunUnzipOnLinux [
	| process |
	Smalltalk os isWindows ifTrue: [ self skip. ^ self ].
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

{ #category : #tests }
PhLProcessWrapperTest >> testRunningInfiniteProcessThrowsTimeout [
	| cmd |
	 cmd := Smalltalk os isWindows 
		ifTrue: [ 'FOR /L %N IN () DO @echo Oops' ]
		ifFalse: [ 'bash -c " while true; do echo ''Hit CTRL+C''; sleep 1; done"' ].
	self 
		should: [ PhLProcessWrapper 
			waitForCommand: cmd
			timeout: 300 milliSeconds. ]
		raise: PhLProcessTimeOut.
]

{ #category : #tests }
PhLProcessWrapperTest >> testRunningShortProcessDoesNotTimeout [
	| cmd |
	 cmd := Smalltalk os isWindows 
		ifTrue: [ 'timeout 1' ]
		ifFalse: [ 'bash -c "sleep 1"' ].
	self 
		shouldnt: [ PhLProcessWrapper 
			waitForCommand: cmd
			timeout: 2 seconds. ]
		raise: PhLProcessTimeOut.
]
