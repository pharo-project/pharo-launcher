Class {
	#name : #PhLProcessWrapperTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #private }
PhLProcessWrapperTest >> performTest [
	"Avoid that TestRunner kills workers of TaskIt => create one new process or each task"
	TKTConfiguration
		runner: TKTNewProcessTaskRunner new
		during: [ super performTest ]
]

{ #category : #tests }
PhLProcessWrapperTest >> testCanRunCommandWithNonAsciiCharacters [
	| process fileRef command |

	fileRef := (FileLocator temp / 'Yann-Gaël Bérès.bat') asFileReference.
	fileRef ensureCreateFile.
	command := Smalltalk os isWindows 
		ifTrue: [ 'dir ' ]
		ifFalse: [ 'ls ' ].
	command := command, (fileRef fullName surroundedByDoubleQuotes).

	process := PhLProcessWrapper waitForCommand: command.
	self assert: process succeeded
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
		ifFalse: [ 'sleep 1' ].
	self 
		shouldnt: [ PhLProcessWrapper 
			waitForCommand: cmd
			timeout: 2 seconds. ]
		raise: PhLProcessTimeOut.
]
