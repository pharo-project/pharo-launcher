"
A PhLImageProcessListCliCommandTest is a test class for testing the behavior of PhLImageProcessListCliCommand
"
Class {
	#name : #PhLImageProcessListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageProcessListCliCommandTest >> testExecute [ 

	self runCommand: #('launcher' 'image' 'processList').
	
	self assertSuccess.
	
	"either there isn't running any image (except currently running launcher) or some image is running (cotaining Pharo term in image arguement of VM path"
	self assert: (self outputString isEmpty or: [ self outputString includesSubstring: 'Pharo'])
]

{ #category : #test }
PhLImageProcessListCliCommandTest >> testProcessListCmdString [

	|processListCmd|
	processListCmd := PhLImageProcessListCliCommand new.
	"test whether current PID of vm is filtered from list"
	self assert: (processListCmd processListCmdString includesSubstring: ('grep -v ', (processListCmd currentVMPid asString))).
	
]
