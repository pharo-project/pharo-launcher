"
A PhLVirtualMachineManagerTest is a test class for testing the behavior of PhLVirtualMachineManager
"
Class {
	#name : #PhLVirtualMachineManagerFunctionalTest,
	#superclass : #PhLVirtualMachineManagerTest,
	#category : 'PharoLauncher-Tests-Functional'
}

{ #category : #'as yet unclassified' }
PhLVirtualMachineManagerFunctionalTest class >> availaibleVirtualMachines [
	Smalltalk vm imageVersionNumber
]

{ #category : #support }
PhLVirtualMachineManagerFunctionalTest >> preSpurHeader [
	^ self getImageHeader: 'http://files.pharo.org/image/50-preSpur/latest.zip'
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanDetectPreSpurImage [
	| version |
	self timeLimit: 60 seconds.
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self preSpurHeader.	
	self assert: (PhLVirtualMachineManager isPreSpur: version)
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanDetectSystemUnzip [
	self assert: PhLVirtualMachineManager canUseSytemZip equals: true
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersion [
	| version manager |
	self timeLimit: 30 seconds.
	
	manager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	manager fetchSourcesFilesFor: '61' in: manager compatibleVm vmFolder.

	
	version := (PhLVirtualMachineManager
		forImage: Smalltalk image lastImagePath) imageVersion.
	self assert: version equals: self currentImageVersion
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromFileWhenRunningExtraVM [
	| vmManager |
	self timeLimit: 30 seconds.
	
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.

	self flag: 'Remove the following instruction once we based Pharo Launcher on Pharo 7: sources file comes with the image. It is actually needed so that the launched image can get environment variables from the system at startup.'.	
	{ vmManager compatibleVm vmFolder . Smalltalk vmBinary parent asFileReference }
		do: [ :each | vmManager fetchSourcesFilesFor: '61' in: each ].

	
	self
		assert: vmManager imageVersion
		equals: self currentImageVersion
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromFileWithRightCommand [
	| vmManager command |
	self timeLimit: 30 seconds.
	
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	command := 'echo 60 > ' , vmManager imageVersionFile fullName surroundedByDoubleQuotes.
		
	self
		assert: (vmManager imageVersionFromFileWith: command)
		equals: '60'
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testGetExceptionWhenRunningImageVersionFromFileWithBadCommand [
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	
	self
		should: [ vmManager imageVersionFromFileWith: 'foo' ]
		raise: PhLImageVersionDeterminationError 
]
