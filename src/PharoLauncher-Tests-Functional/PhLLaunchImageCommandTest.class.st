Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'launchInALoginShellBackup',
		'imageDir'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #private }
PhLLaunchImageCommandTest >> performTest [
	"Avoid that TestRunner kills workers of TaskIt => create one new process or each task"
	TKTConfiguration
		runner: TKTNewProcessTaskRunner new
		during: [ super performTest ]
]

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	launchInALoginShellBackup := PhLImage launchInALoginShell.
	PhLImage launchInALoginShell: false.
	imageDir := FileLocator temp / 'Yann-Gaël Bérès',  UUIDGenerator next asString.
	self deny: imageDir exists.
	imageDir ensureCreateDirectory.
]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [ 
	"imageDir ensureDeleteAll "
	PhLImage launchInALoginShell: launchInALoginShellBackup.
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImageWithNonAsciiCharacters [
	| image |
	
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	
	image launchWithSettings: false.
	
	"ensure image determination succeeded"
	self
		assert: (imageDir / PhLVirtualMachineManager imageVersionFileName) contents
		equals: SystemVersion current major asString , SystemVersion current minor asString.
		
	"image is run but tearDown could delete the image before it is run leading to the dialog to choose the image"
	"for now, no simple way to test that the image is actually launched"
]
