"
I reprensent a Windows process.
You can instantiate me and configure me to run a child process of Pharo. You can wait for my completion or run me in an asynchronuous way (default).
I use a FFI library PhLWinProcessLibrary to make system calls to the Windows API.
I do not manage standard and error outputs.

WARNING: waiting a process will freeze your image while the process is running.

You can use me as following:
	PhLWinProcess new 
		shellCommand: 'echo ok';
		runAndWait.
		
	PhLWinProcess new
		shellCommand: 'timeout 1';
		run.
"
Class {
	#name : #PhLWinProcess,
	#superclass : #Object,
	#instVars : [
		'exitCode',
		'isRunning',
		'startupInfo',
		'processInfo',
		'lastErrorCode',
		'command',
		'arguments',
		'surroundArgumentsWithDoubleQuotes',
		'workingDirectory'
	],
	#pools : [
		'PhLWinTypes'
	],
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #private }
PhLWinProcess class >> TIMEOUT_INFINITE [
	^ 16rffffffff
]

{ #category : #constants }
PhLWinProcess class >> WAIT_FAILED [
	^ 16rFFFFFFFF

]

{ #category : #constants }
PhLWinProcess class >> WAIT_OBJECT_0 [
	^ 0
]

{ #category : #constants }
PhLWinProcess class >> WAIT_TIMEOUT [
	^ 16r00000102
]

{ #category : #configuring }
PhLWinProcess >> arguments: aListOfArguments [
	arguments := aListOfArguments asArray.
]

{ #category : #accessing }
PhLWinProcess >> argumentsString [
	^ Character space join: 
		(surroundArgumentsWithDoubleQuotes
			ifTrue: [ arguments collect: #surroundedByDoubleQuotes ]
			ifFalse: [ arguments ])
]

{ #category : #running }
PhLWinProcess >> basicRun [
	| kNoWindow creationSucceeded |
	kNoWindow := 16r08000000.
	startupInfo := PhLStartupInfoW externalNew.
	startupInfo cb: startupInfo class structureSize.
	processInfo := PhLProcessInformation externalNew.
	
	creationSucceeded := self ffiLibrary
		createProcess: (Win32WideString fromString: command) getHandle
		command: (Win32WideString fromString: self argumentsString) getHandle
		processAttributes: ExternalAddress null
		threadAttributes: ExternalAddress null
		inheritHandles: false
		creationFlags: kNoWindow
		environment: ExternalAddress null
		directory: self workingDirectoryHandle
		startup: startupInfo
		processInformation: processInfo.
		
	creationSucceeded
		ifFalse: [ self setLastErrorCode. PhLWinProcessCreationFailed signal: lastErrorCode ].
	isRunning := true.
]

{ #category : #private }
PhLWinProcess >> clean [
	processInfo getHandle
		ifNotNil: 
			[ self closeHandle: processInfo hProcess.
			self closeHandle: processInfo hThread ].
	processInfo free.
	startupInfo free
]

{ #category : #private }
PhLWinProcess >> closeHandle: handle [
	^ self ffiLibrary closeHandle: handle
]

{ #category : #configuring }
PhLWinProcess >> command: appName [
	"The name of the module to be executed. This module can be a Windows-based application. It can be some other type of module (for example, MS-DOS or OS/2) if the appropriate subsystem is available on the local computer.

The string can specify the full path and file name of the module to execute or it can specify a partial name. In the case of a partial name, the function uses the current drive and current directory to complete the specification. The function will not use the search path. This parameter must include the file name extension; no default extension is assumed."
	command := appName
]

{ #category : #private }
PhLWinProcess >> completionCallback [
	self setExitCode.
	self clean
]

{ #category : #configuring }
PhLWinProcess >> doNotSurroundArgumentsWithDoubleQuotes [
	"useful when you want to pass a command line string instead of a list of arguments"
	surroundArgumentsWithDoubleQuotes := false.
]

{ #category : #accessing }
PhLWinProcess >> exitCode [
	^ exitCode 
]

{ #category : #private }
PhLWinProcess >> ffiLibrary [
	^ PhLWinProcessLibrary uniqueInstance
]

{ #category : #testing }
PhLWinProcess >> hasTimedOut [
	^ self isRunning not 
		and: [ lastErrorCode isNil 
		and: [ exitCode isNil ] ]
]

{ #category : #initialization }
PhLWinProcess >> initialize [
	isRunning := false.
	surroundArgumentsWithDoubleQuotes := true.
]

{ #category : #testing }
PhLWinProcess >> isComplete [
	^ isRunning not and exitCode notNil
]

{ #category : #testing }
PhLWinProcess >> isRunning [
	"see https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-waitforsingleobject for more information"
	| returnValue |
	
	(processInfo isNil 
	or: [ processInfo getHandle isNil 
	or: [ processInfo hProcess getHandle isNil ] ])
		ifTrue: [ ^ false ].
	
	returnValue := self ffiLibrary
		waitForSingleObject: processInfo hProcess
		milliSeconds: 0.
	^ returnValue = self class WAIT_TIMEOUT
]

{ #category : #testing }
PhLWinProcess >> isSuccess [
	^ self isRunning not 
		and: [ lastErrorCode isNil 
		and: [ self exitCode = 0 ] ]
]

{ #category : #public }
PhLWinProcess >> lastError [
	^ self ffiLibrary getLastError
]

{ #category : #running }
PhLWinProcess >> run [
	self basicRun.
	self watch.
]

{ #category : #running }
PhLWinProcess >> runAndWait [
	" This methods runs the subprocess AND waits until the child has exited. "
	
	self basicRun.
	self waitForCompletion.
]

{ #category : #running }
PhLWinProcess >> runAndWaitTimeOut: nbMilliSeconds [
	" This methods runs the subprocess AND waits until the child has exited. "
	
	self basicRun.
	self waitForCompletionTimeout: nbMilliSeconds.
]

{ #category : #running }
PhLWinProcess >> runUnwatch [ 
	"Used to run a process and forget about it"
	self basicRun.
	self clean
]

{ #category : #private }
PhLWinProcess >> setExitCode [
	| exitCodeValueHolder succeeded |
	
	exitCode ifNotNil: [ ^ self ]. "already set"
	
	exitCodeValueHolder := LPDWORD new.
	succeeded := self ffiLibrary
		getProcess: processInfo hProcess
		exitCode: exitCodeValueHolder.
	succeeded ifFalse: [ Warning new messageText: 'Cannot get exit code of the process'; signal ].
	exitCode := exitCodeValueHolder value
]

{ #category : #private }
PhLWinProcess >> setLastErrorCode [
	^ lastErrorCode := self lastError
]

{ #category : #configuring }
PhLWinProcess >> shellCommand: aShellCommandString [
	"This is a simple facility method for the cases when the user wants to use shell as the program.
	This way, the user can directly send shellCommand: 'ECHO y| DEL *.txt' with the whole string 
	rather than having to do set the command cmd.exe, send the '/C' argument, etc etc etc."
	command := 'C:\Windows\System32\cmd.exe'.
	arguments := Array with: '/C' withAll: (Character space split: aShellCommandString).
]

{ #category : #configuring }
PhLWinProcess >> shellCommand: aShellCommandName arguments: aListOfArguments [
	"This is a simple facility method for the cases when the user wants to use shell as the program.
	This way, the user can directly send shellCommand: 'ECHO' arguments: #('1 + 1' '>' 'a filename with spaces.txt')' 
	rather than having to do set the command cmd.exe, send the '/C' argument, etc etc etc."
	command := 'C:\Windows\System32\cmd.exe'.
	arguments := OrderedCollection with: '/C' with: aShellCommandName.
	arguments addAll: aListOfArguments.
	arguments := arguments asArray.
]

{ #category : #public }
PhLWinProcess >> terminate [
	| success |
	self isRunning ifFalse: [ ^ true ].
	
	success := self ffiLibrary 
		terminate: processInfo hProcess 
		exitCode: 3	"Kill the process, set a non-success exit code".
	success ifTrue: [ self clean ].
	^ success
]

{ #category : #private }
PhLWinProcess >> waitForCompletion [
	self waitForCompletionTimeout: self class TIMEOUT_INFINITE.
]

{ #category : #private }
PhLWinProcess >> waitForCompletionTimeout: nbMilliSeconds [
	| returnValue |
	[ returnValue := self ffiLibrary
		waitForSingleObject: processInfo hProcess
		milliSeconds: nbMilliSeconds.
	isRunning := false.
	returnValue = self class WAIT_OBJECT_0
		ifTrue: [ self setExitCode ].	"successful process termination"
	returnValue = self class WAIT_FAILED
		ifTrue: [ self setLastErrorCode ] ]
	ensure: [ self terminate ]
]

{ #category : #private }
PhLWinProcess >> watch [
	(PhLWinProcessWatcher on: self) watch
]

{ #category : #configuring }
PhLWinProcess >> workingDirectory: aPathString [
	workingDirectory := aPathString
]

{ #category : #private }
PhLWinProcess >> workingDirectoryHandle [
	^ workingDirectory 
		ifNil: [ ExternalAddress null ]
		ifNotNil: [ (Win32WideString fromString: workingDirectory) getHandle ]
]
