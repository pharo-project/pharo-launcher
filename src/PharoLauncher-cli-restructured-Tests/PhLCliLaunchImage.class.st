Class {
	#name : #PhLCliLaunchImage,
	#superclass : #ClapPharoCommandsTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #running }
PhLCliLaunchImage >> setUp [
	super setUp.
	imageDir := FileLocator temp / 'pharo-launcher-cli-tests-launch-image-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory
]

{ #category : #running }
PhLCliLaunchImage >> tearDown [
	imageDir ensureDeleteAll.
	(process isNotNil and: [ process isRunning ]) ifTrue: [ process terminate ].
	super tearDown
]

{ #category : #tests }
PhLCliLaunchImage >> testOutputLaunchImage [

	| command model image commandContext |
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: (PhLDirectoryBasedImageRepository forDirectory: imageDir).	
	image := PhLTestImageProvider new copyCurrentImageTo: imageDir.
	"TODO prepare new image launch config without starting ui"
	command := PhLImageLaunchCliCommand asCliCommand: model.
	commandContext := command activationWith: { 'launch' . image name }.

	commandContext execute.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: command process isRunning.
	

	
]
