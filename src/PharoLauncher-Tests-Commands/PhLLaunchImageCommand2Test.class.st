Class {
	#name : #PhLLaunchImageCommand2Test,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLLaunchImageCommand2Test >> setUp [
	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-command',  UUIDGenerator next asString.
	imageDir ensureCreateDirectory.
]

{ #category : #tests }
PhLLaunchImageCommand2Test >> testCanLaunchImage [
	| command image |
	command := PhLLaunchImageCommand new.
	command context: presenter.
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location:  imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major putOn: stream.
			SystemVersion current minor putOn: stream ].
	presenter selection: image.

	command execute.
	
	"we run the image <<unwatch>>. That means we do not have a way to ask information to the process"
	"how to assert the image is run? how to close it?"
]
