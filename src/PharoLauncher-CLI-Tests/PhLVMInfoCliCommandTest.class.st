Class {
	#name : #PhLVMInfoCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMInfoCliCommandTest >> testInfoVmShouldSucceed [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'info' 'myVm1').
	 
	self assert: (self outputString includesSubstring:'valid' caseSensitive: false).
	self assert: (self outputString includesSubstring:'name' caseSensitive: false).
	self assert: (self outputString includesSubstring:'myVm1' caseSensitive: false).
	self assert: (self outputString includesSubstring:'url' caseSensitive: false).
	self assert: (self outputString includesSubstring:'update' caseSensitive: false).
]
