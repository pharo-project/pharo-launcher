Class {
	#name : 'PhLVMListCliCommandTest',
	#superclass : 'PhLVmCliCommandTest',
	#category : 'PharoLauncher-CLI-Tests-Commands',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Commands'
}

{ #category : 'tests' }
PhLVMListCliCommandTest >> testListShowsVersionInstallationDateAndStatus [

	self addVmNamed: 'myVm1'.

	self runCommand: #( 'launcher' 'vm' 'list' ).

	self assertSuccess.
	#( 'Version' 'Installed on' 'Status' '10.3.12' '2026-10-23' 'Update available' ) do: [ :each |
		self assert: (self outputString includesSubstring: each) description: each , ' is not listed' ].
	#( 'Is valid' 'Last update' 'Download URL' ) do: [ :each |
		self deny: (self outputString includesSubstring: each) description: each , ' is still listed' ]
]

{ #category : 'tests' }
PhLVMListCliCommandTest >> testListVirtualMachines [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	self addVmNamed: 'myVm3'.
	
	self runCommand: #('launcher' 'vm' 'list').
	self assertSuccess.
	self assert: (self outputString includesSubstring: 'myVm1').
	self assert: (self outputString includesSubstring: 'myVm2').
	self assert: (self outputString includesSubstring: 'myVm3')
]

{ #category : 'tests' }
PhLVMListCliCommandTest >> testListVirtualMachinesAsSton [
	| vm |
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	self addVmNamed: 'myVm3'.
	
	self runCommand: #('launcher' 'vm' 'list' '--ston').
	self assertSuccess.
	vm := STON fromString: self outputString.
	self assert: vm size equals: 3.
	self assert: vm first id equals: 'myVm3'.
	
]
