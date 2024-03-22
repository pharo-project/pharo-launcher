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
PhLLaunchImageTest >> copyCurrentImageToTestDir [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	
	"avoid to download a compatible VM to determine image pharo version"
	image vmManager imageVersionFile writeStreamDo: [ :stream | 
		stream
			nextPutAll: SystemVersion current major asString;
			nextPutAll: SystemVersion current minor asString ].
		
	^ image
		
	

]

{ #category : #utils }
PhLLaunchImageTest >> copyCurrentVmTo: aDirectory [
	| vmDirectory imageVersion vmId |
	
	vmDirectory := Smalltalk vmDirectory asFileReference.
	imageVersion := SystemVersion current major asString , SystemVersion current minor asString.
	vmId := imageVersion, '-x64'.
	vmDirectory basename = 'pharo-vm'
		ifTrue: [ vmDirectory renameTo: vmId ].
	
	LibC runCommand: 'cp -R ' , vmDirectory fullName , ' ' , aDirectory fullName, '/' , vmId
]

{ #category : #utils }
PhLLaunchImageTest >> pharo80x86Vm [
	^ PhLVirtualMachineManager new virtualMachines
		detect: [ :each | each id = '80-x86' ]
		ifFound: [ :vm | vm isValidAfterUpdate. vm ]
		ifNone: [ self fail: 'cannot find VM!' ]
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
	PhLVirtualMachineManager vmStore: tempVmStoreFolder.
	self copyCurrentVmTo: tempVmStoreFolder.
]

{ #category : #running }
PhLLaunchImageTest >> tearDown [ 
	PhLLaunchConfiguration launchInALoginShell: launchInALoginShellBackup.
	PhLVirtualMachineManager vmStore: vmStoreBackup.
	process ifNotNil: [ process isRunning ifTrue: [ process terminate ] ].
	tempVmStoreFolder ensureDeleteAll.
	imageDir ensureDeleteAll.
	super tearDown
]

{ #category : #tests }
PhLLaunchImageTest >> testArchitectureErrorSignaledWhenTryingToRun32BitImageOn64BitOnlyOS [
	| image |
	image := PhLOsXCatalinaTestImage example32.
	
	self 
		should: [ process := image launchWithConfiguration: nil ]
		raise: PhLArchitectureError
	

]

{ #category : #tests }
PhLLaunchImageTest >> testCanLaunchImageWithNonAsciiCharacters [

	| image |
	image := self copyCurrentImageToTestDir.

	image launch.
	2 seconds wait. "let time to the process to be launched, else test cleanup will interfer with process launch"

	"ensure image determination succeeded"
	self
		assert: (imageDir / PhLImage versionFileName) contents
		equals: SystemVersion current major asString
			, SystemVersion current minor asString

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
	image := PhLOsXCatalinaTestImage example.
	image pharoVersion: '80'.
	commandToEval := '"''' , imageDir fullName , '/result'' asFileReference writeStreamDo:[ :s | s nextPutAll: (1 + 1) asString ]"'.
	config := image defaultLaunchConfiguration.
	config	 imageArguments: {'eval' . commandToEval}.
	
	self 
		shouldnt: [ process := image launchWithConfiguration: config ]
		raise: PhLArchitectureError
	
	

]

{ #category : #tests }
PhLLaunchImageTest >> testLaunchImageSetShouldRunInitilizationScriptToFalse [
	| image |
	
	image := self copyCurrentImageToTestDir.
	
	image launch.
	2 seconds wait. "let time to the process to be launched, else test cleanup will interfer with process launch"
	
	image := PhLImage location: imageDir / FileLocator image basename. "read image metadata from disk"
	self deny: image shouldRunInitializationScript.
]
