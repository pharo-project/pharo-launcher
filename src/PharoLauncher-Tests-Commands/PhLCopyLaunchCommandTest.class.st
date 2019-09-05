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
	presenter := PhLTestImagePresenter new.
]

{ #category : #tests }
PhLCopyLaunchCommandTest >> testCanCopyImageLaunchCommand [
	| command |
	PhLCopyLaunchCommand new
		context: presenter;
		execute.
	
	command := Clipboard clipboardText asString.
	
	self assert: (command beginsWith: 'bash -c ''cd "/TestImage" && "').
	self assert: (command endsWith: 'Pharo.app/Contents/MacOS/Pharo" "/TestImage/TestImage.image" --no-default-preferences''').
]
