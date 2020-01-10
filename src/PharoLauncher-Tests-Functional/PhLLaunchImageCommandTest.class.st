Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'launchInALoginShellBackup',
		'imageDir',
		'vmStoreBackup',
		'tempVmStoreFolder'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #tests }
PhLLaunchImageCommandTest >> pharo80HeadlessVm [
	^ PhLVirtualMachineManager new virtualMachines
		detect: [ :each | each id = '80-x64-headless' ]
		ifFound: [ :vm | vm isValidAfterUpdate. vm ]
		ifNone: [ self fail: 'cannot find VM!' ]
]

{ #category : #tests }
PhLLaunchImageCommandTest >> prepare80imageIn: dir [
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
PhLLaunchImageCommandTest >> setUp [
	launchInALoginShellBackup := PhLLaunchConfiguration launchInALoginShell.
	PhLLaunchConfiguration launchInALoginShell: false.
	imageDir := FileLocator temp / 'Yann-Gaël Bérès',  UUIDGenerator next asString.
	self deny: imageDir exists.
	imageDir ensureCreateDirectory.

	vmStoreBackup := PhLVirtualMachineManager vmStore.
	tempVmStoreFolder := FileLocator temp / self class name, UUIDGenerator next asString.
	PhLVirtualMachineManager vmStore: tempVmStoreFolder.	
]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [ 
	"imageDir ensureDeleteAll "
	PhLLaunchConfiguration launchInALoginShell: launchInALoginShellBackup.
	tempVmStoreFolder ensureDeleteAll.
	PhLVirtualMachineManager vmStore: vmStoreBackup.	
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImageWithHeadlessVM [
	| dir vm image config |
	dir := (FileLocator temp / ('PL-LaunchTest-' , UUIDGenerator next asString)) ensureCreateDirectory.
	image := self prepare80imageIn: dir.
	vm := self pharo80HeadlessVm.
 
	config := image defaultLaunchConfiguration.
	config
		vm: vm;
		vmArguments: #('--headless');
		imageArguments:
			#('eval' '"''result'' asFileReference writeStreamDo:[ :s | s nextPutAll: (1 + 1) asString ]"').
			
	image launchWithConfiguration: config.
	1 second wait. "wait for file generation"
	
	self
		assert: (dir / '80' / 'result') exists
		description: 'Image run did not generate result file.'.
	self
		assert: (dir / '80' / 'result') contents
		equals: '2'
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImageWithNonAsciiCharacters [
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
PhLLaunchImageCommandTest >> testCanLaunchImageWithNonAsciiCharactersUsingLoginShell [
	
	PhLLaunchConfiguration launchInALoginShell: true.
	self testCanLaunchImageWithNonAsciiCharacters.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testLaunchImageSetShouldRunInitilizationScriptToFalse [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image initializationScript: '.' asFileReference.
	
	image launch.
	
	image := PhLImage location: imageDir / FileLocator image basename. "read image metadata from disk"
	self deny: image shouldRunInitializationScript.
]
