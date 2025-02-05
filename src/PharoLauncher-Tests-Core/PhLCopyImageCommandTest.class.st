Class {
	#name : 'PhLCopyImageCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-moved-from-commands',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'moved-from-commands'
}

{ #category : 'running' }
PhLCopyImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : 'tests' }
PhLCopyImageCommandTest >> testCanCopyImageLaunchCommand [
	| image config |
	presenter selectImageAt: 1.
	image := presenter singleImage.
	config := image defaultLaunchConfiguration
		          doNotUseSettings;
		          yourself.
	image launchConfigurations: { config }.
	presenter 
		selection: { image };
		requestAnswer: 'foo'.
	
	PhLCopyImageCommand new
		context: presenter;
		execute.
		
	self assert: (presenter imageRepository hasImageNamed: 'foo').
]
