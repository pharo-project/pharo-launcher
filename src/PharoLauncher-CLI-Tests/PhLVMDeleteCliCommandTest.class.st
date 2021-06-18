Class {
	#name : #PhLVMDeleteCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmShouldSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'myVm1').
	 
	self assert: (( self vmRepository availableVirtualMachines at:'bli') state ) equals: 'successfully deleted'. 
]

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmWrongVmNameShouldRaiseError [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'wrongVmName').
	 
	self assert: ( self errorString includesSubstring: 'please enter a correct local virtual machine' ). 
]
