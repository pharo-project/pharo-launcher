Class {
	#name : #PhLVmProviderUntilPharo80Test,
	#superclass : #TestCase,
	#instVars : [
		'vmProvider'
	],
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #running }
PhLVmProviderUntilPharo80Test >> setUp [
	vmProvider := PhLVmProviderUntilPharo80 new.
]

{ #category : #tests }
PhLVmProviderUntilPharo80Test >> testUrlIsValidAndAvailable [
	| url vm |
	vm := (PhLVirtualMachine id: '80-x64')
			be64bits;
			yourself.
	vmProvider := PhLVmProvider for: vm.
	url := vmProvider url.
	
	self assert: (url asString includesSubstring: '80').
	self assert: (url asString includesSubstring: '64').
	self assert: (ZnEasy head: url) isSuccess
]

{ #category : #tests }
PhLVmProviderUntilPharo80Test >> testUrlIsValidAndAvailableWhenOs64BitAndImageAvailableOnlyIn32Bits [
	| url vm |
	vm := (PhLVirtualMachine id: '40-x86').
	vmProvider := PhLVmProvider for: vm.
	url := vmProvider url.
	
	self assert: (url asString includesSubstring: '40').
	self deny: (url asString includesSubstring: '64').
	self assert: (ZnEasy head: url) isSuccess
]
