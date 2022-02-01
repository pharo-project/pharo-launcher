"
I'm a test resource that mutualize download of image and VMs and provide temporary folders to host them as well as a workspace.

self reset.

self current downloadCompatibleVm64Bit; downloadPharo90Image
"
Class {
	#name : #PhLVirtualMachineManagerTestResource,
	#superclass : #TestResource,
	#instVars : [
		'vmStoreBackup',
		'tempVmStoreFolder',
		'tempFolder',
		'imagesFolder',
		'workspace'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #configuring }
PhLVirtualMachineManagerTestResource >> backupCurrentVmStore [

	vmStoreBackup := PhLVirtualMachineManager vmStore
]

{ #category : #running }
PhLVirtualMachineManagerTestResource >> cleanWorkspace [
	self workspace 
		ensureDeleteAll;
		ensureCreateDirectory.
]

{ #category : #downloading }
PhLVirtualMachineManagerTestResource >> downloadCompatibleVm64Bit [
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: self pharo90image.
	vmManager availableVirtualMachinesByImageFormat
		at: vmManager imageFormatNumber asString
		ifAbsent: [ vmManager fetchCompatibleVm ]  
]

{ #category : #downloading }
PhLVirtualMachineManagerTestResource >> downloadPharo14Image [

	ZipArchive new 
		readFrom: (ZnEasy get: 'http://files.pharo.org/image/14/latest.zip') contents readStream;
		extractAllTo: self pharo14imageFolder ensureCreateDirectory.
]

{ #category : #downloading }
PhLVirtualMachineManagerTestResource >> downloadPharo90Image [
	| httpClient |
	
	httpClient := ZnClient new
		beOneShot;
		maximumEntitySize: 30 * 1024 * 1024;
		url: 'https://files.pharo.org/image/90/stable-64.zip';
		get;
		yourself.
	ZipArchive new 
		readFrom: httpClient response contents readStream;
		extractAllTo: self pharo90imageFolder ensureCreateDirectory.
]

{ #category : #accessing }
PhLVirtualMachineManagerTestResource >> pharo14image [
	self pharo14imageFolder exists
		ifFalse: [ self downloadPharo14Image ].
		
	^ self pharo14imageFolder allFiles 
		detect: [ :each | each basename endsWith: '.image' ]
]

{ #category : #accessing }
PhLVirtualMachineManagerTestResource >> pharo14imageFolder [
	^ imagesFolder / '14'
]

{ #category : #accessing }
PhLVirtualMachineManagerTestResource >> pharo90image [
	self pharo90imageFolder exists
		ifFalse: [ self downloadPharo90Image ].
		
	^ self pharo90imageFolder allFiles 
		detect: [ :each | each basename endsWith: '.image' ]
]

{ #category : #accessing }
PhLVirtualMachineManagerTestResource >> pharo90imageFolder [
	^ imagesFolder / '90'
]

{ #category : #configuring }
PhLVirtualMachineManagerTestResource >> restoreVmStore [

	PhLVirtualMachineManager vmStore: vmStoreBackup
]

{ #category : #running }
PhLVirtualMachineManagerTestResource >> setUp [
	super setUp.
	tempFolder := (FileLocator temp / self class name, UUIDGenerator next asString) ensureCreateDirectory.
	imagesFolder := (tempFolder / 'images') ensureCreateDirectory.
	workspace := (tempFolder / 'workspace') ensureCreateDirectory.
	self setUpTemporaryVmStore.
	self useTemporaryVmStore.

]

{ #category : #initialization }
PhLVirtualMachineManagerTestResource >> setUpTemporaryVmStore [

	self backupCurrentVmStore.
	tempVmStoreFolder := (tempFolder / 'vmStore') ensureCreateDirectory.
]

{ #category : #running }
PhLVirtualMachineManagerTestResource >> tearDown [

	tempFolder ensureDeleteAll.
	self restoreVmStore.
	super tearDown
]

{ #category : #configuring }
PhLVirtualMachineManagerTestResource >> useTemporaryVmStore [

	PhLVirtualMachineManager vmStore: tempVmStoreFolder
]

{ #category : #running }
PhLVirtualMachineManagerTestResource >> withCopyOfPharo14ImageDo: aBlock [
	| imageRef |
	imageRef := self workspace / 'Pharo.image'.
	self pharo14image copyTo: imageRef.
	
	[ aBlock value: imageRef ]
	ensure: [ imageRef ensureDelete ]

]

{ #category : #running }
PhLVirtualMachineManagerTestResource >> withCopyOfPharo90ImageDo: aBlock [
	| imageRef |
	imageRef := self workspace / 'Pharo.image'.
	self pharo90image copyTo: imageRef.
	
	[ aBlock value: imageRef ]
	ensure: [ imageRef ensureDelete ]

]

{ #category : #accessing }
PhLVirtualMachineManagerTestResource >> workspace [
	"The workspace folder is used as a temporary folder by tests and must be reset at the end of the test"
	
	^ workspace
]
