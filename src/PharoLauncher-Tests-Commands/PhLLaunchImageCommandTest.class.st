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
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	presenter selection: image.
	image addLaunchConfiguration: 
		(image defaultLaunchConfiguration 
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself).

	process := command execute.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]
