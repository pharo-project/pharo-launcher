Class {
	#name : #PhLVirtualMachineTest,
	#superclass : #TestCase,
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#category : 'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLVirtualMachineTest >> testCanDetect32BitArchPath [
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x86';
		yourself.
	self 
		assert: vm archPath
		equals: ''
]

{ #category : #tests }
PhLVirtualMachineTest >> testCanDetect64BitArchPath [
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: vm archPath
		equals: '64'
]

{ #category : #tests }
PhLVirtualMachineTest >> testCanDetectExecutablePath [
	"WARNING: this test is Linux specific!"
	| vm vmFolder |
	Smalltalk os isWindows ifTrue: [ self skip. ^ self  ].
	
	vmFolder := FileLocator imageDirectory asFileReference / 'pharo-vm'.
	vm := PhLVirtualMachine directory: vmFolder.
	self 
		assert: vm executablePath
		equals: (vmFolder / PhLVirtualMachine executableName) fullName
]

{ #category : #tests }
PhLVirtualMachineTest >> testCanDetectVMDirectory [
	"WARNING: this test is Linux specific!"
	| vm |
	Smalltalk os isWindows ifTrue: [ self skip. ^ self  ].
	
	vm := PhLVirtualMachine directory: FileLocator imageDirectory asFileReference / 'pharo-vm'.
	self
		assert: vm vmFolderPath
		equals: FileLocator vmDirectory fullName
]

{ #category : #tests }
PhLVirtualMachineTest >> testCanGetDownloadUrl [
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: (self replaceOSByMacIn: vm downloadUrl) 
		equals: 'https://files.pharo.org/get-files/70/pharo64-mac-stable.zip'
]

{ #category : #tests }
PhLVirtualMachineTest >> testCanGetPharoVersion [
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: vm pharoVersion
		equals: '70'
]
