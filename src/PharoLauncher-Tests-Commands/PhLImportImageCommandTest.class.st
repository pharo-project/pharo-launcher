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
	| command images |
	command := PhLImportImageCommand new.
	command context: presenter.
	presenter 
		createImageNamed: 'foo' in: presenter fileSystem / 'tmp';
		requestAnswer:  presenter fileSystem / 'tmp' / 'foo.image'.
	
	command execute.
	
	images := presenter imageRepository imageNames.
	self 
		assert: images size 
		equals: 2.
	self 
		assertCollection: images
		hasSameElements: #('TestImage' 'foo').
]
