Class {
	#name : #PhLImportImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'fs'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLImportImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #tests }
PhLImportImageCommandTest >> testCanImportAnImage [
	| command images someFolder |
	command := PhLImportImageCommand new.
	command context: presenter.
	someFolder := FileSystem memory / 'tmp'.
	presenter 
		createImageNamed: 'foo' in: someFolder;
		requestAnswer:  someFolder / 'foo.image'.
	
	command execute.
	
	images := presenter imageRepository imageNames.
	self 
		assert: images size 
		equals: 2.
	self 
		assertCollection: images
		hasSameElements: #('TestImage' 'foo').
]

{ #category : #tests }
PhLImportImageCommandTest >> testImportNonExistingImage [
	| command |
	command := PhLImportImageCommand new.
	command context: presenter.
	presenter := presenter
		requestAnswer: FileSystem memory / 'tmp' / 'does_not_exists.image'.
		
	self should: [ command execute ] raise: FileDoesNotExistException

]
