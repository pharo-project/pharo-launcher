Class {
	#name : #PhLVirtualMachineTest,
	#superclass : #TestCase,
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#category : #'PharoLauncher-Tests-Functional'
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
PhLVirtualMachineTest >> testCanGetExecutablePathWhenBeeingSerializedAsString [
	| vm |
	vm := STON fromString: 'PhLVirtualMachine {
				#executableRef : ''/Users/me/Documents/Pharo/vms/80-x64/Pharo.app/Contents/MacOS/Pharo'',
				#vmBinaryRef : ''/Users/me/Documents/Pharo/vms/80-x64/Pharo.app/Contents/MacOS/Pharo'',
				#flavour : '''',
				#id : ''80-x64'',
				#blessing : ''stable'',
				#arch : ''64''
}'.	

	self assert: vm executablePath equals: '/Users/me/Documents/Pharo/vms/80-x64/Pharo.app/Contents/MacOS/Pharo'
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

{ #category : #tests }
PhLVirtualMachineTest >> testSerialization [
	| vm vmDirectory deserializedVm vmBinaryRef |
	
	vmDirectory := (FileSystem memory root / '80-x64') ensureCreateDirectory.
	(vmDirectory / PhLVirtualMachine executableName) 
		binaryWriteStreamDo: [ :stream | stream nextPutAll: PhLVirtualMachine elfMagicNumber ].
	vm := PhLVirtualMachine directory: vmDirectory.
	vmBinaryRef := (FileLocator documents / 'Pharo' / 'vms' / '80-x64' / 'pharo') asFileReference.
	vm vmBinary: vmBinaryRef. "do not serialize a memory FS"

	deserializedVm := STON fromString: (STON toStringPretty: vm).
	
	self assert: deserializedVm vmFolder class equals: FileLocator.
	self assert: deserializedVm vmFolder fullName equals: vmBinaryRef parent fullName.
	self assert: deserializedVm id equals: vm id.
	self assert: deserializedVm blessing equals: vm blessing.
	self assert: deserializedVm archPath equals: vm archPath.
	self assert: deserializedVm flavour equals: vm flavour.

]

{ #category : #tests }
PhLVirtualMachineTest >> testvm10IsGreaterThanVm1 [
	| vm10 vm1 |
	vm10 := (PhLVirtualMachine id: '100-x64')
			be64bits;
			yourself.
	vm1 :=  (PhLVirtualMachine id: '10').
	
	self assert: vm10 > vm1

]

{ #category : #tests }
PhLVirtualMachineTest >> testvm64IsGreaterThanVm32 [
	| vm vm64 |
	vm := PhLVirtualMachine id: '90-x86'.
	vm64 :=  (PhLVirtualMachine id: '90')
			be64bits;
			yourself.
	
	self assert: vm64 > vm

]
