Class {
	#name : #PhLVMUpdateCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLVMUpdateCliCommandTest >> testUpdateVmShouldSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('launcher' 'vm' 'update' 'myVm1').
	 
	self assert: ((self vmRepository availableVirtualMachines at:'bli') state ) equals:'updated'
]
