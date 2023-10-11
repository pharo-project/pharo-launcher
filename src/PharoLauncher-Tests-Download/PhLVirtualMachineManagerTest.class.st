Class {
	#name : #PhLVirtualMachineManagerTest,
	#superclass : #TestCase,
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'vmStoreRoot'
	],
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #'as yet unclassified' }
PhLVirtualMachineManagerTest class >> availaibleVirtualMachines [
	Smalltalk vm imageVersionNumber
]

{ #category : #'expected results' }
PhLVirtualMachineManagerTest >> currentImageVersion [
	
	"This test must be rewritten to a controlable version not depending on current image version"
	self skip. 

	^ (SystemVersion current major = 6
		and: [ SystemVersion current highestUpdate >= 60509 ])
		ifTrue: [ '61' ]
		ifFalse: [ SystemVersion current major asString
				, SystemVersion current minor asString ]
]

{ #category : #utilities }
PhLVirtualMachineManagerTest >> getImageHeader: anImageUrl [
	| archive image |
	archive := ZipArchive new 
		readFrom: (ZnEasy get: anImageUrl) contents readStream.
	image:= archive members detect: [ :each | each  fileName endsWith: '.image' ].
	^ (image binaryContentsFrom: 1 to: 4) readStream

]

{ #category : #running }
PhLVirtualMachineManagerTest >> setUp [

	super setUp.
	vmStoreRoot := FileSystem memory root.
]

{ #category : #'input data' }
PhLVirtualMachineManagerTest >> sixtyFourBitsHeader [
	" too long to process this request
		^ self getImageHeader: 'http://files.pharo.org/image/60/latest-64.zip'
	"	
	" Retrieved with:
		'pharo64.image' asFileReference binaryReadStream next: 20
	"
	
	^ #[181 9 1 0 128 0 0 0 112 37 248 2 0 0 0 0 0 64 128 0] readStream "truncated image file"
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testCanDetect32BitsImage [
	| version |
	self timeLimit: 60 seconds.
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self thirtyTwoBitsHeader.
	self assert: (PhLVirtualMachineManager is32bits: version)
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testCanDetect64BitsImage [
	| version |
	self timeLimit: 60 seconds.
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self sixtyFourBitsHeader.
	self assert: (PhLVirtualMachineManager is64bits: version)
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testCanGetAvailableVirtualMachinesEvenIfVMExecutableNotFound [
	| vmManager vms |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	
	PhLVirtualMachineManager 
		useVmStore: vmStoreRoot 
		during: [self 
		createVmNamed: '400-x86';
		createVmNamed: '500-x64'.
	(vmStoreRoot / '900-x64') ensureCreateDirectory. "invalid VM. Correct folder with no exe"	
	
	 vms := vmManager availableVirtualMachines ].
	
	self assert: vms size equals: 2.
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testCanGetImageFormatNumber [
	| version |
	version := PhLVirtualMachineManager imageFormatNumberFromFile: Smalltalk image lastImagePath.
		
	self assert: version isInteger.
	self
		assert: version
		equals: Smalltalk imageFormatVersion
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testCanGetImageVersionFromFile [
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile 
		ensureDelete;
		writeStreamDo: [ :stream | stream << '60' ].
		
	self
		assert: vmManager imageVersionFromFile
		equals: '60'
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testGetExceptionWhenRunningImageVersionFromFileAndFileIsAbsent [
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		should: [ vmManager imageVersionFromFile ]
		raise: PhLImageVersionDeterminationError 
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testImageVersionDeterminationScriptIsUpdatedWhenFileContentDifferentFromScriptInImage [
	| vmManager scriptPath |
	vmManager := PhLVirtualMachineManager new.
	scriptPath := vmManager imageVersionDeterminationScriptPath.
	
	scriptPath asFileReference
		ensureDelete;
		writeStreamDo: [ :stream | stream nextPutAll: 'foo' ].
	self 
		assert: scriptPath asFileReference contents 
		equals: 'foo'.	
	
	vmManager imageVersionDeterminationScriptPath. "Should update the file with right content"
	
	self deny: (scriptPath asFileReference contents includesSubstring: 'foo')
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testPharo50PreSpurImageUrlIsCorrect [
	| url |
	url := PhLVirtualMachineManager new
		imageFormatNumber: PhLVirtualMachineManager imageFormatPreSpur;
		imageVersion: '50';
		vmUrl.
	self assert: (self replaceOSByMacIn: url) equals: 'https://files.pharo.org/get-files/50-preSpur/pharo-mac-stable.zip'
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testPharo60VmUrlIsCorrect [
	| url |
	url := PhLVirtualMachineManager new
		imageFormatNumber: PhLVirtualMachineManager imageFormat32bits;
		imageVersion: '60';
		vmUrl.
	self assert: (self replaceOSByMacIn: url) equals: 'https://files.pharo.org/get-files/60/pharo-mac-stable.zip'
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testPharo70Vm64BitsUrlIsCorrect [
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormat64bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/70/pharo64-mac-stable.zip' 
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testPharo70VmUrlIsCorrect [
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormat32bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/70/pharo-mac-stable.zip' 
]

{ #category : #tests }
PhLVirtualMachineManagerTest >> testPreSpurImageUrlIsCorrect [
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormatPreSpur;
		imageVersion: '40';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/40/pharo-mac-stable.zip' 
]

{ #category : #'input data' }
PhLVirtualMachineManagerTest >> thirtyTwoBitsHeader [
	" too long to process this request
		^ self getImageHeader: 'http://files.pharo.org/image/60/latest.zip'
	"	
	" Retrieved with:
		'pharo.image' asFileReference binaryReadStream next: 20
	"
	^ #[121 25 0 0 64 0 0 0 8 84 50 2 112 76 76 10 216 156 254 11] readStream "truncated image file"
]

{ #category : #accessing }
PhLVirtualMachineManagerTest >> vmStoreRoot [

	^ vmStoreRoot
]
