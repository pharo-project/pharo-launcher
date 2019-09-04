Class {
	#name : #PhLRenameImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLRenameImageCommandTest >> setUp [
	presenter := PhLTestImagePresenter new.
]

{ #category : #tests }
PhLRenameImageCommandTest >> testCanRenameAnImage [
	| command images |
	command := PhLRenameImageCommand2 new.
	presenter requestAnswer: 'TestRenameImage'.
	command context: presenter.
	command execute.
	
	images := command imagesPresenter imageRepository imageNames.
	
	self
		assertCollection: images
		hasSameElements: #('TestRenameImage').
]

{ #category : #tests }
PhLRenameImageCommandTest >> testCannotRenameAnImageWithAnExistingName [
	| command images |
	command := PhLRenameImageCommand2 new.
	presenter requestAnswer: 'TestImage'.
	command context: presenter.
	command execute.
	
	images := command imagesPresenter imageRepository imageNames.
	
	self
		assertCollection: images
		hasSameElements: #('TestImage')
]
