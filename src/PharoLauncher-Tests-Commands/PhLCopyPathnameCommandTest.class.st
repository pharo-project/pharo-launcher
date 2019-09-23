Class {
	#name : #PhLCopyPathnameCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLCopyPathnameCommandTest >> setUp [
	presenter := PhLTestImagesPresenter new.
]

{ #category : #tests }
PhLCopyPathnameCommandTest >> testCanCopyImagePathname [
	PhLCopyPathname2 new
		context: presenter;
		execute.
	
	self
		assertCollection: Clipboard clipboardText asString
		equals: '"/TestImage/TestImage.image"'.
]
