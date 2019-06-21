Class {
	#name : #PhLProcessWrapperTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunCommandWithNonAsciiCharacters [
	| process fileRef |

	fileRef := (FileLocator temp / 'Yann-Gaël Bérès.bat') asFileReference.
	fileRef ensureCreateFile.

	process := PhLProcessWrapper new 
		shellCommand;
		addArgument: (Smalltalk os isWindows 
			ifTrue: [ 'dir' ]
			ifFalse: [ 'ls' ]);
		addArgument: fileRef fullName surroundedByDoubleQuotes;
		runAndWait.
	self assert: process isSuccess
]

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunUnzipOnLinux [
	Smalltalk os isWindows ifTrue: [ self skip. ^ self ].

	self assert: (PhLProcessWrapper isCommandAvailable: 'ls').
	self deny: (PhLProcessWrapper isCommandAvailable: 'foobar').
]

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunUnzipOnWindows [
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].

	self assert: (PhLProcessWrapper isCommandAvailable: 'dir').
	self deny: (PhLProcessWrapper isCommandAvailable: 'foobar').
]

{ #category : #tests }
PhLProcessWrapperTest >> testRunningInfiniteProcessThrowsTimeout [
	| process |
	process := PhLProcessWrapper new 
		shellCommand;
		yourself.
	Smalltalk os isWindows 
		ifTrue: [ process addArgument: 'FOR /L %N IN () DO @echo Oops' ]
		ifFalse: [ process addArgument: 'bash -c " while true; do echo ''Hit CTRL+C''; sleep 1; done"' ].

	self 
		should: [ process runAndWaitTimeOut: 300 milliSeconds. ]
		raise: PhLProcessTimeOut.
]

{ #category : #tests }
PhLProcessWrapperTest >> testRunningShortProcessDoesNotTimeout [
	| cmd |
	 cmd := Smalltalk os isWindows 
		ifTrue: [ 'timeout 1' ]
		ifFalse: [ 'sleep 1' ].
	self 
		shouldnt: [ PhLProcessWrapper new 
			shellCommand;
			addArguments: cmd;
			runAndWaitTimeOut: 2 seconds ]
		raise: PhLProcessTimeOut.
]
