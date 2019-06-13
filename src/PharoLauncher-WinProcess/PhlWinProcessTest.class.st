Class {
	#name : #PhlWinProcessTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #tests }
PhlWinProcessTest >> testBasicCommand [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := PhLWinProcess new 
		shellCommand: 'echo ok';
		runAndWait.
	self deny: newprocess isRunning.
	self assert: newprocess exitCode equals: 0.
	self assert: newprocess isSuccess

]

{ #category : #tests }
PhlWinProcessTest >> testBasicCommandWithArguments [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := PhLWinProcess new 
		shellCommand: 'echo'
		arguments: #('ok');
		runAndWait.
	self deny: newprocess isRunning.
	self assert: newprocess exitCode equals: 0.
	self assert: newprocess isSuccess

]

{ #category : #tests }
PhlWinProcessTest >> testCanDetectIfProcessIsRunning [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := PhLWinProcess new
		shellCommand: 'timeout 1';
		run.
	self assert: newprocess isRunning.
	1 seconds wait.
	self deny: newprocess isRunning.
		
]

{ #category : #tests }
PhlWinProcessTest >> testCanTerminateProcess [
	| newprocess succeeded |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := PhLWinProcess new 
		shellCommand: 'timeout 50';
		run.
	self assert: newprocess isRunning.
	succeeded := newprocess terminate.
	self assert: succeeded.
	1 second wait. "let time to the cleanup being executed"
	self deny: newprocess isRunning.
	self deny: newprocess isSuccess.
]

{ #category : #tests }
PhlWinProcessTest >> testGivenACommandWhenContainsNonAsciiCharsThenCommandSucceed [
	| newprocess tempDir |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	tempDir := (FileLocator temp / 'Yann-Gaël Bérès') asFileReference.
	self deny: tempDir exists.
	
	[ newprocess := PhLWinProcess new 
		shellCommand: 'mkdir'
		arguments: {tempDir fullName surroundedByDoubleQuotes};
		runAndWait.
	self assert: newprocess isSuccess.
	self assert: tempDir exists. ]
		ensure: [ tempDir ensureDelete ]
	

]

{ #category : #tests }
PhlWinProcessTest >> testGivenBasicCommandWhenCommandDoesNotExistThenExitCodeIsNot0 [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := PhLWinProcess new 
		shellCommand: 'nonexistingcommand foo bar'.
	self deny: newprocess exitCode equals: 0.
	self deny: newprocess isSuccess
]

{ #category : #tests }
PhlWinProcessTest >> testProcessTimeOut [
	| newprocess start delta |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	start := Time now asMilliSeconds.
	newprocess := PhLWinProcess new 
		shellCommand: 'timeout 50';
		run;
		waitForCompletionTimeout: 3 seconds asMilliSeconds.
	"wait is blocking"
	delta := Time now asMilliSeconds - start.
	self deny: newprocess isRunning.
	self deny: newprocess isSuccess.
	self assert: (delta between: 3 seconds asMilliSeconds and: 4 seconds asMilliSeconds).
	self assert: newprocess hasTimedOut
]
