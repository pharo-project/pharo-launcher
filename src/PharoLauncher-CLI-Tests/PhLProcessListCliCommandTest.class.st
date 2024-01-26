"
A PhLImageProcessListCliCommandTest is a test class for testing the behavior of PhLImageProcessListCliCommand
"
Class {
	#name : #PhLProcessListCliCommandTest,
	#superclass : #PhLProcessCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLProcessListCliCommandTest >> testExecute [ 

	self runCommand: #('launcher' 'process' 'list').
	
	self assertSuccess.
	
	"either there isn't running any image (except currently running launcher) or some image is running (containing Pharo term in image argument of VM path"
	self assert: (self outputString isEmpty or: [ self outputString includesSubstring: 'Pharo'])
]

{ #category : #tests }
PhLProcessListCliCommandTest >> testOsShellArgArray [

	|processListCmd argArray|
	processListCmd := PhLProcessListCliCommand new.
	argArray := processListCmd osShellArgArray.
	
	"test whether current PID of vm is filtered from list"
	
	self assert: (argArray third includesSubstring: 'pgrep').
	self assert: (argArray third includesSubstring: ('grep -v ', (processListCmd currentVMPid asString))).
]
