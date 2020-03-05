Class {
	#name : #PhLCopyLaunchCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLCopyLaunchCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #tests }
PhLCopyLaunchCommandTest >> testCanCopyImageLaunchCommand [
	| image config commandString |
	image := presenter singleImage.
	config := image defaultLaunchConfiguration
		          doNotUseSettings;
		          yourself.
	image launchConfigurations: { config }.
	presenter selection: image.
	
	PhLCopyLaunchCommand new
		context: presenter;
		execute.
		
	commandString := Clipboard clipboardText asString.
	self assert:
		(commandString beginsWith: 'bash -c ''cd "/TestImage" && ').
	self assert: (commandString endsWith:
			 ' "/TestImage/TestImage.image" --no-default-preferences''')
]
