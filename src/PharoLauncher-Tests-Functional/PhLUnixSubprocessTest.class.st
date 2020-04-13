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
	"Exit code is 1 on OS X, 2 on Linux"
	self assert: (#(1 2) includes: process exitStatusInterpreter statusIfExited).

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
		assert: (process stderrStream upToEndOfFile trimBoth 
			includesSubstring: 'ls: /foo/bar: No such file or directory').
]
