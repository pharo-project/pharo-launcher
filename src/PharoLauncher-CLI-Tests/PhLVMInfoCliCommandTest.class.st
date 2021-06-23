Class {
	#name : #PhLVMInfoCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMInfoCliCommandTest >> testInfoVmShouldSucceed [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'info' 'myVm1').
	 
	self assert: (self outputString includesSubstring:'some random update time'). 
]
