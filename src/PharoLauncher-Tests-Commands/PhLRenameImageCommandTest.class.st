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
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #tests }
PhLRenameImageCommandTest >> testCanRenameAnImage [
	| command images |
	command := PhLRenameImageCommand new.
	presenter requestAnswer: 'TestRenameImage'.
	command context: presenter.
	command execute.
	
	images := command imagesPresenter imageNames.
	
	self
		assertCollection: images
		hasSameElements: #('TestRenameImage').
]

{ #category : #tests }
PhLRenameImageCommandTest >> testCannotRenameAnImageWithAnExistingName [
	| command images |
	command := PhLRenameImageCommand new.
	presenter requestAnswer: 'TestImage'.
	command context: presenter.
	command execute.
	
	images := command imagesPresenter imageNames.
	
	self
		assertCollection: images
		hasSameElements: #('TestImage')
]
