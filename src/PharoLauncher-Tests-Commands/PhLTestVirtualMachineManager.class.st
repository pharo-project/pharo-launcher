"
Virtual Machine manager for test purposes.
I mock network calls.
"
Class {
	#name : #PhLTestVirtualMachineManager,
	#superclass : #PhLVirtualMachineManager,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #private }
PhLTestVirtualMachineManager class >> fetch: aVmUrl to: targetFile [
	| vmFolder |
	vmFolder := targetFile parent / targetFile basenameWithoutExtension.
	vmFolder ensureCreateDirectory.
	(vmFolder / 'fetched!') ensureCreateFile.
]

{ #category : #private }
PhLTestVirtualMachineManager class >> vmStore [
	^ vmStore ifNil: [ vmStore := FileSystem memory root ]
]

{ #category : #adding }
PhLTestVirtualMachineManager >> createVmNamed: aName [
	| vmDirectory appDir  |
	vmDirectory := self vmStore / aName.
	vmDirectory ensureCreateDirectory.
	"needed on OS X"
	appDir := (vmDirectory / 'Pharo.app') ensureCreateDirectory.
	(appDir / 'Pharo') ensureCreateFile.
	"needed on Linux"
	(vmDirectory / 'pharo') binaryWriteStreamDo: [ :stream | stream nextPutAll: PhLVirtualMachine elfMagicNumber ].
]
