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
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #running }
PhLDeleteImageCommandTest >> tearDown [
	presenter delete.
	super tearDown
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testCanDeleteAnImage [
	| command images |
	command := PhLDeleteImageCommand new.
	command context: presenter.
	presenter 
		createImageNamed: 'Foo';
		selectImageAt: 1.
		
	command execute.
	
	images := command imagesPresenter imageNames.
	self
		assertCollection: images
		hasSameElements: #('Foo').
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testImagesPresenterIsRefreshedWhenImageDeleted [
	| command images |
	command := PhLDeleteImageCommand new.
	command context: presenter.
	presenter
		openWithSpec;
		selectImageAt: 1.

	command execute.

	images := command imagesPresenter imageNames.
	self
		assertEmpty: images;
		assert: (presenter imageLabel beginsWith: 'No image selected')
]
