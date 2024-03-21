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
	#category : #'PharoLauncher-Tests-Debug'
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

	| vmManager expectedVersion imageRef |
	
	
	expectedVersion := '110'.
	imageRef :=  PhLVirtualMachineManagerTestResource current workspace / 'Pharo.image'.
	vmManager := PhLVirtualMachineManager forImage: imageRef.
	vmManager imageVersionFile ensureDelete.
	vmManager imageVersionFile writeStreamDo: [ :stream | stream nextPutAll: expectedVersion ].
			
	self assert: vmManager imageVersion equals: expectedVersion
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
