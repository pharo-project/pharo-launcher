"
A PhLVirtualMachineManagerTest is a test class for testing the behavior of PhLVirtualMachineManager
"
Class {
	#name : #PhLVirtualMachineManagerFunctionalTest,
	#superclass : #PhLVirtualMachineManagerTest,
	#instVars : [
		'vmStoreBackup',
		'tempVmStoreFolder'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #accessing }
PhLVirtualMachineManagerFunctionalTest class >> resources [

	^ Array with: PhLVirtualMachineManagerTestResource 
]

{ #category : #support }
PhLVirtualMachineManagerFunctionalTest >> preSpurHeader [
	^ self getImageHeader: 'http://files.pharo.org/image/50-preSpur/latest.zip'
]

{ #category : #running }
PhLVirtualMachineManagerFunctionalTest >> setUp [
	super setUp.
	
	PhLVirtualMachineManagerTestResource current cleanWorkspace.
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
	self assert: PhLVirtualMachineManager canUseSytemZip
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersion [

	| version |
	self timeLimit: 30 seconds.

	PhLVirtualMachineManagerTestResource current 
		withCopyOfPharo90ImageDo: [ :imageRef | 
			version := (PhLVirtualMachineManager forImage: imageRef)
				           imageVersion.
			self assert: version equals: '90' ]
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromFileWhenRunningExtraVM [

	| vmManager |
	self timeLimit: 30 seconds.

	PhLVirtualMachineManagerTestResource current
		withCopyOfPharo90ImageDo: [ :imageRef | 
			vmManager := PhLVirtualMachineManager forImage: imageRef.
			vmManager imageVersionFile ensureDelete.

			self assert: vmManager imageVersion equals: '90' ]
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromFileWithRightCommand [
	| vmManager command |
	self timeLimit: 30 seconds.
	
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	command := PhLProcessWrapper new 
		shellCommand;
		addArguments: 'echo 60 >';
		addArgument: vmManager imageVersionFile fullName surroundedByDoubleQuotes.
		
	self
		assert: (vmManager imageVersionFromFileWith: command)
		equals: '60'
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromPharo14Image [

	| vmManager |
	self skip: 'skip this test for now to allow a release soon'.
	self timeLimit: 60 seconds.

	PhLVirtualMachineManagerTestResource current 
		withCopyOfPharo14ImageDo: [ :imageRef | 
			vmManager := PhLVirtualMachineManager forImage: imageRef.
			vmManager imageVersionFile ensureDelete.

			self assert: vmManager imageVersion equals: '14' ]
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testGetExceptionWhenRunningImageVersionFromFileWithBadCommand [

	| vmManager command |
	command := PhLProcessWrapper new
		           shellCommand;
		           addArgument: 'foo'.

	PhLVirtualMachineManagerTestResource current 
		withCopyOfPharo90ImageDo: [ :imageRef | 
			vmManager := PhLVirtualMachineManager forImage: imageRef.
			vmManager imageVersionFile ensureDelete.

			self
				should: [ vmManager imageVersionFromFileWith: command ]
				raise: PhLImageVersionDeterminationError ]
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testImageVersionDeterminationIsRunWithoutSettings [
	| manager command |
	manager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	
	command := manager imageVersionCommandWithPreferences: false.
	
	self assert: (command arguments includes: '--no-default-preferences')
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> withCopyOfCurrentImageDo: aBlock [
	| imagePath imageRef |
	imageRef := Smalltalk image lastImagePath asFileReference.
	imagePath := FileLocator temp / imageRef basename.
	imageRef copyTo: imagePath.
	
	[ aBlock value: imagePath ]
	ensure: [ imagePath asFileReference ensureDelete ]

]
