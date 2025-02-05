Class {
	#name : 'PhLRefreshImagerepositoryCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-not-faulty',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'not-faulty'
}

{ #category : 'running' }
PhLRefreshImagerepositoryCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : 'tests' }
PhLRefreshImagerepositoryCommandTest >> testCanRefreshImageList [
	| command images |
	command := PhLRefreshImageRepositoryCommand new.
	command context: presenter.
	images := presenter imageRepository imageNames.
	presenter createImageNamed: 'Foo'.
	
	command execute.
	
	self 
		assertCollection: presenter imageNames
		hasSameElements: (images copyWith: 'Foo').
	
]
