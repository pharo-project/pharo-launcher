Class {
	#name : #PhLVMListCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMListCliCommandTest >> testListVirtualMachines [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	self addVmNamed: 'myVm3'.
	
	self runCommand: #('launcher' 'vm' 'list').
	
	self assert: (self outputString includesSubstring: 'myVm1').
	self assert: (self outputString includesSubstring: 'myVm2').
	self assert: (self outputString includesSubstring: 'myVm3')
]

{ #category : #tests }
PhLVMListCliCommandTest >> testListVirtualMachinesAsSton [
	| vm |
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	self addVmNamed: 'myVm3'.
	
	self runCommand: #('launcher' 'vm' 'list' '--ston').
	
	vm := STON fromString: self outputString.
	self assert: vm size equals: 3.
	self assert: vm first id equals: 'myVm3'.
	
]
