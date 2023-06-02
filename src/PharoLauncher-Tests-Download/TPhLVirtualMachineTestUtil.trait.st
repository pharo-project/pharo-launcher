Trait {
	#name : #TPhLVirtualMachineTestUtil,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #adding }
TPhLVirtualMachineTestUtil >> createVmNamed: aName [
	self createVmNamed: aName private: false
]

{ #category : #adding }
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
	(vmDirectory / PhLVirtualMachine executableName) 
		binaryWriteStreamDo: [ :stream | stream nextPutAll: PhLVirtualMachine elfMagicNumber ].
]

{ #category : #tests }
TPhLVirtualMachineTestUtil >> replaceOSByMacIn: url [
	^ (url copyReplaceAll: 'linux' with: 'mac') copyReplaceAll: 'win' with: 'mac'
]
