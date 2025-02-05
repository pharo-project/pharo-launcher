Class {
	#name : 'PhLCopyPathnameCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-Move-From-Commands',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'Move-From-Commands'
}

{ #category : 'running' }
PhLCopyPathnameCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : 'tests' }
PhLCopyPathnameCommandTest >> testCanCopyImagePathname [
	presenter selectImageAt: 1.
	PhLCopyPathname new
		context: presenter;
		execute.
	
	self
		assertCollection: Clipboard clipboardText asString
		equals: '"/TestImage/TestImage.image"'.
]
