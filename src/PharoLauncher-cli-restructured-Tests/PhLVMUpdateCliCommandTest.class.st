Class {
	#name : #PhLVMUpdateCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLVMUpdateCliCommandTest >> PhLCliSpecificCommand [
	^ PhLVmUpdateCliCommand asCliCommand: model
]

{ #category : #tests }
PhLVMUpdateCliCommandTest >> testUpdateVmSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('update' 'myVm1').
	 
	self assert: ((model vmBaseRepository availableVirtualMachines at:'bli') state ) equals:'updated'
]
