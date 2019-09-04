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

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	launchInALoginShellBackup := PhLImage launchInALoginShell.
	PhLImage launchInALoginShell: false.
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
	PhLImage launchInALoginShell: launchInALoginShellBackup.
	tempVmStoreFolder ensureDeleteAll.
	PhLVirtualMachineManager vmStore: vmStoreBackup.	
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImageWithNonAsciiCharacters [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	
	image launchWithSettings: false.
	
	"ensure image determination succeeded"
	self
		assert: (imageDir / PhLImage versionFileName) contents
		equals: SystemVersion current major asString , SystemVersion current minor asString.
		
	"image is run but tearDown could delete the image before it is run leading to the dialog to choose the image"
	"for now, no simple way to test that the image is actually launched"
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImageWithNonAsciiCharactersUsingLoginShell [
	
	PhLImage launchInALoginShell: true.
	self testCanLaunchImageWithNonAsciiCharacters.
]
