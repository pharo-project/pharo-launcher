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
	process ifNotNil: [ process terminate ].
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

	process := command execute.
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]
