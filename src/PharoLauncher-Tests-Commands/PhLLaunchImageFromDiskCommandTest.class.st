Class {
	#name : #PhLLaunchImageFromDiskCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir',
		'process'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLLaunchImageFromDiskCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-from-disk-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory
]

{ #category : #running }
PhLLaunchImageFromDiskCommandTest >> tearDown [
	imageDir ensureDeleteAll.
	presenter delete.
	(process isNotNil and: [ process isRunning ])
		ifTrue: [ process terminate ].
]

{ #category : #tests }
PhLLaunchImageFromDiskCommandTest >> testCanLaunchImageFromDisk [
	| command image |
	command := PhLLaunchImageFromDiskCommand new.
	command context: presenter.
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	presenter requestAnswer: image file.
	presenter openWithSpec.
	image addLaunchConfiguration: 
		(image defaultLaunchConfiguration 
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself).

	process := command launchImage: image. "allow to specify arguments to the default configuration for test purposes"
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]
