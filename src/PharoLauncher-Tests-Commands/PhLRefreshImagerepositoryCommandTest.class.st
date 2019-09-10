Class {
	#name : #PhLRefreshImagerepositoryCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLRefreshImagerepositoryCommandTest >> setUp [
	presenter := PhLTestImagePresenter new.
]

{ #category : #tests }
PhLRefreshImagerepositoryCommandTest >> testCanRefreshImageList [
	| command images |
	command := PhLRefreshImageRepositoryCommand2 new.
	command context: presenter.
	images := presenter imageRepository imageNames.
	presenter createImageNamed: 'Foo'.
	
	command execute.
	
	self 
		assertCollection: presenter imageRepository imageNames
		hasSameElements: (images copyWith: 'Foo').
	
]
