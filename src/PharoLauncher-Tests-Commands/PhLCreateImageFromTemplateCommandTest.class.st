Class {
	#name : #PhLCreateImageFromTemplateCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLCreateImageFromTemplateCommandTest >> setUp [
	presenter := PhLTestTemplatesPresenter new.
]

{ #category : #tests }
PhLCreateImageFromTemplateCommandTest >> testCanCreateAnImageWhenSingleTemplateSelected [
	| command images |
	command := PhLCreateImageFromTemplateCommand new.
	command context: presenter.
	presenter 
		createLocalTemplateNamed: 'Foo';
		selectCategory: 1;
		selectTemplateNamed: 'Foo'.
		
	command execute.
	
	images := presenter imageRepository imageNames.
	self 
		assert: images size 
		equals: 1.
	self 
		assertCollection: images
		hasSameElements: #('TestCreateImage').
]

{ #category : #tests }
PhLCreateImageFromTemplateCommandTest >> testCannotCreateAnImageWhenManyTemplatesSelected [
	| command |
	command := PhLCreateImageFromTemplateCommand new.
	command context: presenter.
	presenter 
		createLocalTemplateNamed: 'Foo';
		createLocalTemplateNamed: 'Bar';
		selectTemplateNamed: 'Foo';
		selectTemplateNamed: 'Bar'.
		
	self 
		should: [ command execute ]
		raise: PhLCommandError
]

{ #category : #tests }
PhLCreateImageFromTemplateCommandTest >> testCannotCreateAnImageWhenNoTemplateSelected [
	| command |
	command := PhLCreateImageFromTemplateCommand new.
	command context: presenter.

	self
		should: [ command execute ]
		raise: PhLCommandError
]
