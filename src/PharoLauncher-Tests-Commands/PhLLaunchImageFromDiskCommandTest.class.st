Class {
	#name : 'PhLLaunchImageFromDiskCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'imageDir',
		'process'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLLaunchImageFromDiskCommandTest class >> resources [

	^ { PhLPharoStableImageResource }
]

{ #category : 'running' }
PhLLaunchImageFromDiskCommandTest >> setUp [

	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : 'running' }
PhLLaunchImageFromDiskCommandTest >> tearDown [
	presenter delete.
	(process isNotNil and: [ process isRunning ]) ifTrue: [ process terminate ].
	super tearDown
]

{ #category : 'tests' }
PhLLaunchImageFromDiskCommandTest >> testCanLaunchImageFromDisk [
	| command image |
	command := PhLLaunchImageFromDiskCommand new.
	command context: presenter.
	image := PhLPharoStableImageResource current newImage.
	presenter requestAnswer: image file.
	presenter open.
	image addLaunchConfiguration: 
		(image defaultLaunchConfiguration asLaunchConfiguration
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself).

	process := command launchImage: image. "allow to specify arguments to the default configuration for test purposes"
	2 seconds wait. "let time to the image to be opened by the VM"
	
	self assert: process isRunning.
]
