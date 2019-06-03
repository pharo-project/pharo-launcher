"
This class  allow to run external (OS) processes for the Pharo Launcher.
It hides some complexity to the Launcer.
OSProcess is used on Linux and OS X, while ProcessWrapper is used on Windows (OSProcess hangs on some processes on Windows and the Launcher becomes unusable).
"
Class {
	#name : #PhLProcessWrapper,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : 'PharoLauncher-Core-Download'
}

{ #category : #'execution - public' }
PhLProcessWrapper class >> command: aCommand [

	| encodedCommand |
	encodedCommand := self encode: aCommand.
	^ Smalltalk os isWindows
			ifTrue: [ self windowsCommand: encodedCommand ]
			ifFalse: [ OSProcess command: encodedCommand ]
]

{ #category : #encoding }
PhLProcessWrapper class >> encode: aCommand [

	| encoded |
	
	(aCommand isWideString and: [ Smalltalk os isWindows ])
		ifTrue: [ PhLNotSupportedCharacterError signal ].

	encoded := Smalltalk os isWindows
		ifTrue: [ aCommand ]
	 	ifFalse: [ aCommand utf8Encoded asString ].
	^ encoded
]

{ #category : #testing }
PhLProcessWrapper class >> isCommandAvailable: aCommand [
	| process |
	
	[ process := self waitForCommand: aCommand.
	^ process succeeded ]
	on: Error 
	do: [ ^ false ]
]

{ #category : #'execution - public' }
PhLProcessWrapper class >> waitForCommand: aCommand [
	| encodedCommand |
	encodedCommand := self encode: aCommand.
	^ self new
		process: (Smalltalk os isWindows
			ifTrue: [ self waitForWindowsCommand: encodedCommand ]
			ifFalse: [ self waitForLinuxCommand: encodedCommand ]);
		yourself
]

{ #category : #'execution - public' }
PhLProcessWrapper class >> waitForCommand: aCommand timeout: aDuration [
	Smalltalk os isWindows
			ifTrue: [ self waitForWindowsCommand: aCommand timeout: aDuration ]
			ifFalse: [ self waitForLinuxCommand: aCommand timeout: aDuration ]
]

{ #category : #private }
PhLProcessWrapper class >> waitForLinuxCommand: aCommand [ 
	^ OSProcess waitForCommand: aCommand
]

{ #category : #'execution - public' }
PhLProcessWrapper class >> waitForLinuxCommand: aCommand timeout: aDuration [
	| future externalProcess |
	
	future := [externalProcess := self command: aCommand.
				 [externalProcess isComplete] 
					whileFalse: [(Delay forMilliseconds: 50) wait]. ] future.
	[ future waitForCompletion: aDuration ]
		on: TKTTimeoutException 
		do: [ :error | 
				externalProcess isComplete ifFalse:
					[ externalProcess sigkill.
					PhLProcessTimeOut signal ] ]
]

{ #category : #private }
PhLProcessWrapper class >> waitForWindowsCommand: commandString [
	| process |
	process := PhLWinProcess new
		doNotSurroundArgumentsWithDoubleQuotes;
		shellCommand: commandString;
		runAndWait.
	
	process isSuccess ifFalse: [
		self error: 'command ', commandString ,' failed' ].

	^ process
]

{ #category : #'execution - public' }
PhLProcessWrapper class >> waitForWindowsCommand: commandString timeout: aDuration [
	| process |
	process := PhLWinProcess new
		doNotSurroundArgumentsWithDoubleQuotes;
		shellCommand: commandString;
		run;
		waitForCompletionThenCleanTimeout: aDuration asMilliSeconds.
	
	process hasTimedOut
		ifTrue: [ PhLProcessTimeOut signal ].
	process isSuccess
		ifFalse: [ self error: 'command ', commandString ,' failed' ].

	^ process
]

{ #category : #private }
PhLProcessWrapper class >> windowsCommand: aCommand [
	^ PhLWinProcess new
		doNotSurroundArgumentsWithDoubleQuotes;
		shellCommand: aCommand;
		run
]

{ #category : #accessing }
PhLProcessWrapper >> exitCode [
	^ Smalltalk os isWindows
		ifTrue: [ process exitCode ] 
		ifFalse: [ process exitStatus ]
]

{ #category : #private }
PhLProcessWrapper >> process: aProcessWrapper [ 
	process := aProcessWrapper
]

{ #category : #testing }
PhLProcessWrapper >> succeeded [
	^ Smalltalk os isWindows
		ifTrue: [ process isRunning not and: [ process exitCode == 0 ] ] 
		ifFalse: [ process succeeded ]
]
