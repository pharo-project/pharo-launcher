Class {
	#name : #PhLLaunchImageTest,
	#superclass : #TestCase,
	#instVars : [
		'launchInALoginShellBackup',
		'imageDir',
		'vmStoreBackup',
		'tempVmStoreFolder',
		'resultDir',
		'process'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLLaunchImageTest >> pharo80x86Vm [
	^ PhLVirtualMachineManager new virtualMachines
		detect: [ :each | each id = '80-x86' ]
		ifFound: [ :vm | vm isValidAfterUpdate. vm ]
		ifNone: [ self fail: 'cannot find VM!' ]
]

{ #category : #tests }
PhLLaunchImageTest >> prepare80imageIn: dir [
	| imageFile |
	ZnClient new
		url: 'https://files.pharo.org/image/80/latest-minimal-64.zip';
		downloadTo: dir / '80.zip'.
	ZipArchive new
		readFrom: dir / '80.zip';
		extractAllTo: dir / '80'.
	imageFile := (dir / '80' childrenMatching: '*.image') first.
	dir / '80' / PhLImage versionFileName
		writeStreamDo: [ :s | s nextPutAll: '80' ].
	^ PhLImage location: imageFile.
]

{ #category : #running }
PhLLaunchImageTest >> setUp [
	| uuid |
	super setUp.
	launchInALoginShellBackup := PhLLaunchConfiguration launchInALoginShell.
	PhLLaunchConfiguration launchInALoginShell: false.
	uuid := UUIDGenerator next asString.
	imageDir := FileLocator temp / 'Yann-Gaël Bérès' , uuid.
	self deny: imageDir exists.
	imageDir ensureCreateDirectory.
	vmStoreBackup := PhLVirtualMachineManager vmStore.
	tempVmStoreFolder := FileLocator temp / self class name , uuid.
	PhLVirtualMachineManager vmStore: tempVmStoreFolder
]

{ #category : #running }
PhLLaunchImageTest >> tearDown [ 
	PhLLaunchConfiguration launchInALoginShell: launchInALoginShellBackup.
	tempVmStoreFolder ensureDeleteAll.
	PhLVirtualMachineManager vmStore: vmStoreBackup.
	imageDir ensureDeleteAll.
	process ifNotNil: [ process isRunning ifTrue: [ process terminate ] ].
	super tearDown
]

{ #category : #tests }
PhLLaunchImageTest >> testArchitectureErrorSignaledWhenTryingToRun32BitImageOn64BitOnlyOS [
	| image |
	image := PhLOsXMojaveTestImage example32.
	
	self 
		should: [ process := image launchWithConfiguration: nil ]
		raise: PhLArchitectureError
	

]

{ #category : #tests }
PhLLaunchImageTest >> testCanLaunchImageWithNonAsciiCharacters [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	
	image launch.
	
	"ensure image determination succeeded"
	self
		assert: (imageDir / PhLImage versionFileName) contents
		equals: SystemVersion current major asString , SystemVersion current minor asString.
		
	"image is run but tearDown could delete the image before it is run leading to the dialog to choose the image"
	"for now, no simple way to test that the image is actually launched"
]

{ #category : #tests }
PhLLaunchImageTest >> testCanLaunchImageWithNonAsciiCharactersUsingLoginShell [
	
	PhLLaunchConfiguration launchInALoginShell: true.
	self testCanLaunchImageWithNonAsciiCharacters.
]

{ #category : #tests }
PhLLaunchImageTest >> testCanRun64bitImageOn64BitOnlyOS [
	| image config commandToEval |
	image := PhLOsXMojaveTestImage example.
	commandToEval := '"''' , imageDir fullName , '/result'' asFileReference writeStreamDo:[ :s | s nextPutAll: (1 + 1) asString ]"'.
	config := image defaultLaunchConfiguration.
	config
		vm: self pharo80x86Vm;
		imageArguments: {'eval' . commandToEval}.
	
	self 
		shouldnt: [ process := image launchWithConfiguration: config ]
		raise: PhLArchitectureError
	
	

]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchImageSetShouldRunInitilizationScriptToFalse [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image initializationScript: '.' asFileReference.
	
	image launch.
	
	image := PhLImage location: imageDir / FileLocator image basename. "read image metadata from disk"
	self deny: image shouldRunInitializationScript.
]
