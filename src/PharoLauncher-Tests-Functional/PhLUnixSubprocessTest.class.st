"
This class contains tests to ensure we can expected behaviour from the library used
"
Class {
	#name : #PhLUnixSubprocessTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLUnixSubprocessTest >> testCanGetExitStatusFromLaunchCommand [
	| process |
	process := OSSUnixSubprocess new 
		command: '/bin/ls';
		arguments: #( '/foo/bar' );
		yourself.
		
	process run.
	500 milliSeconds wait.
	
	self assert: process isComplete.
	self deny: process isSuccess.
	self assert: process exitStatusInterpreter isExited.
	self assert: process exitStatusInterpreter statusIfExited equals: 1.

]

{ #category : #tests }
PhLUnixSubprocessTest >> testCanGetStdErrFromLaunchCommand [
	| process |
	process := OSSUnixSubprocess new 
		command: '/bin/ls';
		arguments: #( '/foo/bar' );
		redirectStderr;
		yourself.
		
	process run.
	500 milliSeconds wait.
	
	self assert: process isComplete.
	self deny: process isSuccess.
	self 
		assert: process stderrStream upToEndOfFile trimBoth 
		equals: 'ls: /foo/bar: No such file or directory'.
]
