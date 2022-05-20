"
This class allows to run external (OS) processes for Pharo Launcher.
It hides some complexity to the Launcher.
OSSubProcess is used on Linux and OS X, while OSWinSubprocess is used on Windows.

Use me as a builder to configure the process, then call prepareProcess (will use a visitor pattern to visit code specific to targeted OS) to have a PhLProcess ready to run.
I act as a facade to OSSubProcess and OSWinSubprocess.
"
Class {
	#name : #PhLProcessWrapper,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'process',
		'arguments',
		'command',
		'workingDirectory',
		'isShellCommand',
		'useLoginShell'
	],
	#category : #'PharoLauncher-Core-Download'
}

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
	"On Linux and OS X, we give an array of arguments to the process. 
	If the command is a shell, then pathes HAVE TO be protected with double quotes.
	It the command is pharo-vm, then pathes SHOULD NOT be surrounded by double quotes, else they are interpreted as part of the argument. This is not true on Windows because arguments is a String with all arguments. It means we MUST keep double quotes for windows pathes.
	We assume that arguments are already protected (user knows what to protect, we cannot guess)."
	(isShellCommand or: [ Smalltalk os isWindows ])
		ifTrue: [ ^ arguments asArray ].
	^ arguments
		collect:	[ :arg | 
			(arg first = $" and: [ arg last = $" ])
				ifTrue: [ arg allButFirst allButLast ]
				ifFalse: [ arg ] ]
		as: Array
]

{ #category : #accessing }
PhLProcessWrapper >> command [ 
	^ command
]

{ #category : #building }
PhLProcessWrapper >> command: apathString [
	command := apathString
]

{ #category : #querying }
PhLProcessWrapper >> commandLineString [
	^ PhLProcessWrapperCommandStringGenerator new 
		processWrapper: self;
		visit
]

{ #category : #accessing }
PhLProcessWrapper >> exitCode [
	^ Smalltalk os isWindows
		ifTrue: [ process exitCode ] 
		ifFalse: [ process exitStatus ]
]

{ #category : #initialization }
PhLProcessWrapper >> initialize [
	super initialize.
	arguments := OrderedCollection new.
	isShellCommand := false.
	useLoginShell := false
]

{ #category : #testing }
PhLProcessWrapper >> isRunning [
	^ process isRunning
]

{ #category : #testing }
PhLProcessWrapper >> isShellCommand [
	^ isShellCommand
]

{ #category : #testing }
PhLProcessWrapper >> isSuccess [
	^ Smalltalk os isWindows
		ifTrue: [ process isRunning not and: [ process exitCode == 0 ] ] 
		ifFalse: [ process isSuccess ]
]

{ #category : #building }
PhLProcessWrapper >> loginShellCommand [ 
	self shellCommand.
	useLoginShell := true.
]

{ #category : #private }
PhLProcessWrapper >> prepareProcess [
	"I am an OSPlatform visitor. Running the visit will actually configure thr process dependending on the Operating System"
	self visit
]

{ #category : #private }
PhLProcessWrapper >> process: aProcessWrapper [ 
	process := aProcessWrapper
]

{ #category : #running }
PhLProcessWrapper >> runAndWait [
	self prepareProcess.
	process runAndWait.
	
	process isSuccess ifFalse: [
		self error: 'command ', self commandLineString ,' failed' ].

]

{ #category : #running }
PhLProcessWrapper >> runAndWaitTimeOut: aDuration [
	Smalltalk os isWindows
		ifTrue: [ self runOnWindowsAndWaitTimeOut: aDuration ]
		ifFalse: [ self runOnLinuxAndWaitTimeOut: aDuration ]
]

{ #category : #running }
PhLProcessWrapper >> runOnLinuxAndWaitTimeOut: aDuration [
	self prepareProcess.
	[ process 
		run;
		waitForExitWithTimeout: aDuration ]
	on: OSSTimeout
	do: [ PhLProcessTimeOut signal ].
]

{ #category : #running }
PhLProcessWrapper >> runOnWindowsAndWaitTimeOut: aDuration [
	self prepareProcess.
	process runAndWaitTimeOut: aDuration asMilliSeconds.
	
	process hasTimedOut
		ifTrue: [ PhLProcessTimeOut signal ].

]

{ #category : #running }
PhLProcessWrapper >> runUnwatch [
	self prepareProcess.
	Smalltalk os isWindows
		ifTrue: [ process runUnwatch. ]
		ifFalse: [ process run. ]
]

{ #category : #building }
PhLProcessWrapper >> shellCommand [ 
	isShellCommand := true.
]

{ #category : #accessing }
PhLProcessWrapper >> stderrString [
	^ Smalltalk os isWindows
		ifTrue: [ 'Std error not available on Windows' ]
		ifFalse: [ (process stderrStream upToEndOfFile ifNil: [ '' ]) trimBoth ]
]

{ #category : #terminating }
PhLProcessWrapper >> terminate [ 
	process terminate
]

{ #category : #private }
PhLProcessWrapper >> visitMacOS: aPlatform [
	self visitUnix: aPlatform
]

{ #category : #private }
PhLProcessWrapper >> visitUnix: aPlatform [
	process := OSSUnixSubprocess new
		workingDirectory: workingDirectory;
		"redirectStderr;" "Waiting for https://github.com/pharo-contributions/OSSubprocess/issues/58 to be fixed"
		yourself.
	isShellCommand 
		ifTrue: [ | commandLine |
			commandLine := Character space join: self arguments.
			useLoginShell 
				ifTrue: [ process loginShellCommand: commandLine ]
				ifFalse: [ process shellCommand: commandLine ] ] 
		ifFalse: [ process command: command.
					process arguments: self arguments. ].
]

{ #category : #private }
PhLProcessWrapper >> visitWindows: aPlatform [
	process := OSWSWinProcess new
		workingDirectory: workingDirectory;
		yourself.
	isShellCommand 
		ifTrue: [ process shellCommand ] 
		ifFalse: [ process command: command ].
	process arguments: self arguments.
]

{ #category : #accessing }
PhLProcessWrapper >> workingDirectory [ 
	^ workingDirectory 
]

{ #category : #building }
PhLProcessWrapper >> workingDirectory: apathString [
	workingDirectory := apathString
]
