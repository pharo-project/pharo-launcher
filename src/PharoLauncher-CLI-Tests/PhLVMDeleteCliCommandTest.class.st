Class {
	#name : #PhLVMDeleteCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmShouldSucceed [

	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
		
	self runCommand: #('launcher' 'vm' 'delete' 'myVm1').
	self assertSuccess. 
	self assert: (( self vmRepository availableVirtualMachines at:'myVm1') isDeleted)
]

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmWithWrongVmNameShouldGiveBackNotFoundMessage [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'wrongVmName').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'enter a correct VM id')
]
