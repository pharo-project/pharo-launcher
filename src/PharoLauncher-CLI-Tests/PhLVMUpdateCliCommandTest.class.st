Class {
	#name : #PhLVMUpdateCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMUpdateCliCommandTest >> testUpdateVmShouldSucceed [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'update' 'myVm1').
	 
	self assert: ((self vmRepository availableVirtualMachines at:'myVm1') state ) equals:'updated'
]
