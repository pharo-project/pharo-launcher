Class {
	#name : #PhLVMListCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLVMListCliCommandTest >> testListVirtualMachines [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	self addVmNamed: 'myVm2' at: 'blu'.

	self runCommand: #('launcher' 'vm' 'list').
	 
   self assert: self outputString equals: 'myVm1
myVm2
myVm2
'

]
