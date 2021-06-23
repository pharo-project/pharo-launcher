Class {
	#name : #PhLVMListCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMListCliCommandTest >> testListVirtualMachines [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	self addVmNamed: 'myVm3' at: 'blu'.

	self runCommand: #('launcher' 'vm' 'list').
	 
   self assert: (self outputString includesSubstring:'myVm1').
	self assert: (self outputString includesSubstring:'myVm2').
	self assert: (self outputString includesSubstring:'myVm3')

]
