Class {
	#name : #PhLVMInfoCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLVMInfoCliCommandTest >> testInfoVmShouldSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('launcher' 'vm' 'info' 'myVm1').
	 
	self assert: (self outputString includesSubstring:'some random update time'). 
]
