"
This class  allow to run external (OS) processes for the Pharo Launcher.
It hides some complexity to the Launcer.
OSProcess is used on Linux and OS X, while ProcessWrapper is used on Windows (OSProcess hangs on some processes on Windows and the Launcher becomes unusable).
"
Class {
	#name : #PhLProcessWrapper,
	#superclass : #Object,
	#instVars : [
		'process',
		'arguments',
		'command',
		'workingDirectory',
		'isShellCommand'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'execution - public' }
PhLProcessWrapper class >> command: aCommand [
	^ Smalltalk os isWindows
			ifTrue: [ PhLWinProcess new
							shellCommand: aCommand;
							run ]
			ifFalse: [ OSProcess command: aCommand utf8Encoded asString ]
]

{ #category : #testing }
PhLProcessWrapper class >> isCommandAvailable: aCommand [
	| process |
	
	[ process := self new 
		shellCommand;
		addArgument: aCommand;
		runAndWaitTimeOut: 2 seconds.
		^ process isSuccess ]
	on: Error 
	do: [ ^ false ]
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

{ #category : #building }
PhLProcessWrapper >> addArgument: aString [
	arguments add: aString
]

{ #category : #building }
PhLProcessWrapper >> addArguments: aString [
	self addArguments: aString separator: Character space
]

{ #category : #building }
PhLProcessWrapper >> addArguments: aString separator: aCharacter [
	(aCharacter split: aString)
		do: [ :arg | self addArgument: arg ]
]

{ #category : #accessing }
PhLProcessWrapper >> arguments [
	^ arguments asArray
]

{ #category : #building }
PhLProcessWrapper >> command: apathString [
	command := apathString
]

{ #category : #accessing }
PhLProcessWrapper >> exitCode [
	^ Smalltalk os isWindows
		ifTrue: [ process exitCode ] 
		ifFalse: [ process exitStatus ]
]

{ #category : #initialization }
PhLProcessWrapper >> initialize [ 
	arguments := OrderedCollection new.
	isShellCommand := false.
]

{ #category : #testing }
PhLProcessWrapper >> isSuccess [
	^ Smalltalk os isWindows
		ifTrue: [ process isRunning not and: [ process exitCode == 0 ] ] 
		ifFalse: [ process succeeded ]
]

{ #category : #private }
PhLProcessWrapper >> linuxCommandLine [
	| commandLine |
	
	commandLine := workingDirectory 
		ifNil: [ '' ]
		ifNotNil: ['cd ' , workingDirectory , ' && ' ].
	isShellCommand 
		ifFalse: [ commandLine := commandLine , command surroundedByDoubleQuotes, ' ' ].
	commandLine := commandLine , (Character space join: self arguments).
	^ isShellCommand 
		ifTrue: [ 'bash -c ''{1}''' format: { commandLine }]
		ifFalse: [ commandLine ]

]

{ #category : #building }
PhLProcessWrapper >> loginShellCommand [ 
	self shellCommand.
	Smalltalk os isWindows 
		ifFalse: [ arguments addFirst: '-l' ].
]

{ #category : #private }
PhLProcessWrapper >> prepareWindowsProcess [
	process := PhLWinProcess new
		workingDirectory: workingDirectory;
		yourself.
	isShellCommand 
		ifTrue: [ process shellCommand ] 
		ifFalse: [ process command: command ].
	process arguments: self arguments.
]

{ #category : #private }
PhLProcessWrapper >> process: aProcessWrapper [ 
	process := aProcessWrapper
]

{ #category : #running }
PhLProcessWrapper >> runAndWait [
	Smalltalk os isWindows
		ifTrue: [ self runOnWindowsAndWait ]
		ifFalse: [ self runOnLinuxAndWait ]
]

{ #category : #running }
PhLProcessWrapper >> runAndWaitTimeOut: aDuration [
	Smalltalk os isWindows
		ifTrue: [ self runOnWindowsAndWaitTimeOut: aDuration ]
		ifFalse: [ self runOnLinuxAndWaitTimeOut: aDuration ]
]

{ #category : #running }
PhLProcessWrapper >> runOnLinuxAndWait [
	process := OSProcess waitForCommand: self linuxCommandLine utf8Encoded asString.
]

{ #category : #running }
PhLProcessWrapper >> runOnLinuxAndWaitTimeOut: aDuration [
	| future |
	
	future := [ process := OSProcess command: self linuxCommandLine utf8Encoded asString.
				 [ process isComplete] 
					whileFalse: [(Delay forMilliseconds: 50) wait]. ] future.
	[ future waitForCompletion: aDuration ]
		on: TKTTimeoutException 
		do: [ :error | 
				process isComplete ifFalse:
					[ process sigkill.
					PhLProcessTimeOut signal ] ]
]

{ #category : #running }
PhLProcessWrapper >> runOnWindowsAndWait [
	self prepareWindowsProcess.
	process runAndWait.
	
	process isSuccess ifFalse: [
		self error: 'command ', command ,' failed' ].

]

{ #category : #running }
PhLProcessWrapper >> runOnWindowsAndWaitTimeOut: aDuration [
	self prepareWindowsProcess.
	process runAndWaitTimeOut: aDuration asMilliSeconds.
	
	process hasTimedOut
		ifTrue: [ PhLProcessTimeOut signal ].

]

{ #category : #running }
PhLProcessWrapper >> runUnwatch [
	Smalltalk os isWindows
		ifTrue: [ self prepareWindowsProcess. 
					process runUnwatch. ]
		ifFalse: [ self halt ]
]

{ #category : #building }
PhLProcessWrapper >> shellCommand [ 
	isShellCommand := true.
]

{ #category : #building }
PhLProcessWrapper >> workingDirectory: apathString [
	workingDirectory := apathString
]
