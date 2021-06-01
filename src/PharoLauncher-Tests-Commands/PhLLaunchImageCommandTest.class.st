Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir',
		'process'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory
]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [
	imageDir ensureDeleteAll.
	(process isNotNil and: [ process isRunning ]) ifTrue: [ process terminate ].
	super tearDown
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImage [
	| command image |
	command := PhLLaunchImageCommand new.
	command context: presenter.
	image := PhLTestImageProvider new copyCurrentImageTo: imageDir.
	presenter selection: image.
	

	process := command execute.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]
