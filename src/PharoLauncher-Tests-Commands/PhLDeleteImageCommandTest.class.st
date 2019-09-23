Class {
	#name : #PhLDeleteImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLDeleteImageCommandTest >> setUp [
	presenter := PhLTestImagesPresenter new.
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testCanDeleteAnImage [
	| command images |
	command := PhLDeleteImageCommand2 new.
	command context: presenter.
	presenter createImageNamed: 'Foo'.
	command execute.
	
	images := command imagesPresenter imageRepository imageNames.
	
	self
		assertCollection: images
		hasSameElements: #('Foo').
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testCanDeleteManyImages [
	| command images |
	command := PhLDeleteImageCommand2 new.
	command context: presenter.
	presenter 
		createImageNamed: 'Foo';
		selectionNames: #('Foo' 'TestImage').
	command execute.
	
	images := command imagesPresenter imageRepository imageNames.
	
	self
		assertCollection: images
		hasSameElements: #().
]
