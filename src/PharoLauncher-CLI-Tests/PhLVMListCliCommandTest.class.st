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
	| test |
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	self addVmNamed: 'myVm3'.
	
	self runCommand: #('launcher' 'vm' 'list' '--ston').
	
	"self assert: (self outputString  includesSubstring: 'PhLVitualMachinesMock{#id:''myVm3''')."
	test:= STON fromString: self outputString.
	self assert: (test at:1) id equals: 'myVm3' 
	
]
