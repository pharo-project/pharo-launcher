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
	self assert: (self outputString includesSubstring: 'Pharo')
]
