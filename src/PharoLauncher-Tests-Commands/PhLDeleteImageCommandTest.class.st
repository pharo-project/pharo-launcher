Class {
	#name : #PhLDeleteImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #helper }
PhLDeleteImageCommandTest >> createMoreImagesAndEnableSorting [

	presenter createImageNamed: 'Zoo'.
	presenter createImageNamed: 'Abc'.
	presenter application imageRepositoryChanged.
	presenter
		open;
		selectImageAt: 1.

	presenter
		clickOnColumnHeaderAt: 1;
		selectImageAt: 3 "Zoo"
]

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
PhLDeleteImageCommandTest >> testDeleteTheRightImageIfImagesSortingIsNotTheDefaultOne [
	| command images |
	command := PhLDeleteImageCommand new.
	command context: presenter.
	self createMoreImagesAndEnableSorting. "xx image is selected"

	command execute.

	images := command imagesPresenter imageNames.
	self deny: (images includes: 'Zoo')
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testImagesPresenterIsRefreshedWhenImageDeleted [

	| command images |
	command := PhLDeleteImageCommand new.
	command context: presenter.
	presenter
		open;
		selectImageAt: 1.

	command execute.

	images := command imagesPresenter imageNames.
	self
		assertEmpty: images;
		assert: (presenter imageLabel beginsWith: 'No image selected')
]

{ #category : #tests }
PhLDeleteImageCommandTest >> testWarningMessageWhenDeletingManyImages [
	| command images |
	command := PhLDeleteImageCommand new.
	command context: presenter.
	presenter 
		createImageNamed: 'Foo';
		createImageNamed: 'Bar';
		createImageNamed: 'baz';
		refresh;
		selectImagesAt: #(1 3).
		
	command execute.
	
	images := command imagesPresenter imageNames.
	self
		assertCollection: images
		hasSameElements: #('Bar' 'TestImage').
	self
		assert: presenter request message
		equals: 'Are you sure you want to delete 2 images: baz and Foo?'
]
