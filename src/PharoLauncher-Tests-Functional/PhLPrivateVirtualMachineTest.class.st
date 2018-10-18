Class {
	#name : #PhLPrivateVirtualMachineTest,
	#superclass : #TestCase,
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#category : 'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLPrivateVirtualMachineTest >> testCanGetDownloadUrl [
	| vm |
	vm := PhLPrivateVirtualMachine new 
		basicInitializeOn: FileSystem memory / '6521';
		yourself.
	self 
		assert: (self replaceOSByMacIn: vm downloadUrl)
		equals: 'https://files.pharo.org/get-files/70/pharo-mac-stable.zip'
]
