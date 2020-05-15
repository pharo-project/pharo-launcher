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

{ #category : #support }
PhLVirtualMachineManagerFunctionalTest >> preSpurHeader [
	^ self getImageHeader: 'http://files.pharo.org/image/50-preSpur/latest.zip'
]

{ #category : #running }
PhLVirtualMachineManagerFunctionalTest >> setUp [
	super setUp.
	vmStoreBackup := PhLVirtualMachineManager vmStore.
	tempVmStoreFolder := FileLocator temp / self class name , UUIDGenerator next asString.
	PhLVirtualMachineManager vmStore: tempVmStoreFolder
]

{ #category : #running }
PhLVirtualMachineManagerFunctionalTest >> tearDown [
	tempVmStoreFolder ensureDeleteAll.
	PhLVirtualMachineManager vmStore: vmStoreBackup.
	super tearDown
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
	
	self withCopyOfCurrentImageDo: 
	[ :imagePath |
	version := (PhLVirtualMachineManager forImage: imagePath) 
		imageVersion.
	self assert: version equals: self currentImageVersion ]
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testCanGetImageVersionFromFileWhenRunningExtraVM [
	| vmManager |
	self timeLimit: 30 seconds.
	
	self withCopyOfCurrentImageDo: 
	[ :imagePath |
	vmManager := PhLVirtualMachineManager forImage:imagePath.
	vmManager imageVersionFile ensureDelete.

	self
		assert: vmManager imageVersion
		equals: self currentImageVersion ]
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
	| vmManager destDir image |
	self skip: 'skip this test for now to allow a release soon'.
	self timeLimit: 60 seconds.

	destDir := FileLocator temp	/ ('pharo-launcher-testCanGetImageVersionFromPharo14Image-', UUIDGenerator next asString).
	ZipArchive new 
		readFrom: (ZnEasy get: 'http://files.pharo.org/image/14/latest.zip') contents readStream;
		extractAllTo: destDir.
	destDir allFiles 
		detect: [ :each | each basename endsWith: '.sources' ]
		ifFound: #ensureDelete.
	image := destDir allFiles detect: [ :each | each basename endsWith: '.image' ].
	vmManager := PhLVirtualMachineManager forImage: image.
	vmManager imageVersionFile ensureDelete.

	"self flag: 'Remove the following instruction once we based Pharo Launcher on Pharo 7: sources file comes with the image. It is actually needed so that the launched image can get environment variables from the system at startup.'.	
	{ vmManager compatibleVm vmFolder . Smalltalk vmBinary parent asFileReference }
		do: [ :each | vmManager fetchSourcesFilesFor: '61' in: each ]."
	self
		assert: vmManager imageVersion
		equals: '14'
]

{ #category : #tests }
PhLVirtualMachineManagerFunctionalTest >> testGetExceptionWhenRunningImageVersionFromFileWithBadCommand [
	| vmManager command |
	
	command := PhLProcessWrapper new 
		shellCommand;
		addArgument: 'foo'.
		
	self withCopyOfCurrentImageDo: 
	[ :imagePath |
	vmManager := PhLVirtualMachineManager forImage: imagePath.
	vmManager imageVersionFile ensureDelete.
	
	self
		should: [ vmManager imageVersionFromFileWith: command ]
		raise: PhLImageVersionDeterminationError. ]
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
