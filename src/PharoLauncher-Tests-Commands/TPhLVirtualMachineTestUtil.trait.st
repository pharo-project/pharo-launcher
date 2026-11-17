Trait {
	#name : 'TPhLVirtualMachineTestUtil',
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'adding' }
TPhLVirtualMachineTestUtil >> createVmBinary: aFileReference [
	"On Linux, a folder is a VM only if it holds an ELF binary"

	aFileReference binaryWriteStreamDo: [ :stream | stream nextPutAll: PhLVirtualMachine elfMagicNumber ]
]

{ #category : 'adding' }
TPhLVirtualMachineTestUtil >> createVmNamed: aName [
	self createVmNamed: aName private: false
]

{ #category : 'adding' }
TPhLVirtualMachineTestUtil >> createVmNamed: aName private: isPrivateVm [
	| vmDirectory appDir root |
	root := isPrivateVm 
		ifTrue: [ self vmStoreRoot / 'private' ] 
		ifFalse: [ self vmStoreRoot ].
	vmDirectory := root / aName.
	vmDirectory ensureCreateDirectory.
	
	"needed on OS X"
	appDir := (vmDirectory / 'Pharo.app') ensureCreateDirectory.
	(appDir / 'Pharo') ensureCreateFile.
	
	"needed on Linux"
	self createVmBinary: vmDirectory / PhLVirtualMachine executableName
]

{ #category : 'adding' }
TPhLVirtualMachineTestUtil >> makeExecutableOf: aVm print: aString [
	"Replace the executable of the VM by a script printing the given text. The VM must be on disk.
	The binary moves to lib/, as in the VMs published for Linux, so that the folder is still found as a VM."

	| executable |
	executable := aVm executablePath asFileReference.
	self createVmBinary: (executable parent / 'lib') ensureCreateDirectory / PhLVirtualMachine executableName.
	executable
		ensureDelete;
		writeStreamDo: [ :stream |
			stream << '#!/bin/sh' << String lf << 'echo "' << aString << '"' << String lf ].
	aVm ensureExecutionRights
]

{ #category : 'tests' }
TPhLVirtualMachineTestUtil >> replaceOSByMacIn: url [
	^ (url copyReplaceAll: 'linux' with: 'mac') copyReplaceAll: 'win' with: 'mac'
]
