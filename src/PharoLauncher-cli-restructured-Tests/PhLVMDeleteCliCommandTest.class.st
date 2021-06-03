Class {
	#name : #PhLVMDeleteCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLVMDeleteCliCommandTest >> PhLCliSpecificCommand [
	^ PhLVmUpdateCliCommand asCliCommand: model
]

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('delete' 'myVm1').
	 
	self assert: ((model vmBaseRepository availableVirtualMachines at:'bli') state ) equals: 'successfully deleted'. 
]
