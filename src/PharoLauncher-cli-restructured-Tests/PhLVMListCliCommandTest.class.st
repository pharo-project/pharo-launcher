Class {
	#name : #PhLVMListCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLVMListCliCommandTest >> PhLCliSpecificCommand [
	^ PhLVmListCliCommand asCliCommand: model
]

{ #category : #tests }
PhLVMListCliCommandTest >> testListVirtualMachines [
   | output |
	
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	self addVmNamed: 'myVm2' at: 'blu'.

	self runCommand: #('list').
	
 	output := 'stdio stdout contents utf8Decoded'. 
   self assert: output equals: 'MyVirtualMachine2
MyVirtualMachine3
MyVirtualMachine
'

]
