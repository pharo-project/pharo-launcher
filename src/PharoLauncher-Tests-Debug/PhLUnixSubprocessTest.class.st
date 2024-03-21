"
This class contains tests to ensure we can expected behaviour from the library used
"
Class {
	#name : #PhLUnixSubprocessTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Debug'
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
	| process stdErrString |
	process := OSSUnixSubprocess new 
		command: '/bin/ls';
		arguments: #( '/foo/bar' );
		redirectStderr;
		yourself.
		
	process run.
	500 milliSeconds wait.
	
	self assert: process isComplete.
	self deny: process isSuccess.
	stdErrString := process stderrStream upToEndOfFile.
	self 
		assert: ( stdErrString includesSubstring: 'No such file or directory')
		description: 'Cannot find "No such file or directory" in std err stream'.
	self 
		assert: (stdErrString includesSubstring: '/foo/bar')
		description: 'Cannot find "/foo/bar" in std err stream'.
	self 
		assert: (stdErrString includesSubstring: 'ls')
		description: 'Cannot find "ls" in std err stream'.
]
