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
	command := PhLCreateImageFromTemplateCommand2 new.
	command context: presenter.
	presenter 
		createTemplateNamed: 'Foo';
		selectionNames: #('Foo').
		
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
	command := PhLCreateImageFromTemplateCommand2 new.
	command context: presenter.
	presenter 
		createTemplateNamed: 'Foo';
		createTemplateNamed: 'Bar';
		selectionNames: #('Foo' 'Bar').
		
	self 
		should: [ command execute ]
		raise: PhLCommandError
]

{ #category : #tests }
PhLCreateImageFromTemplateCommandTest >> testCannotCreateAnImageWhenNoTemplateSelected [
	| command |
	command := PhLCreateImageFromTemplateCommand2 new.
	command context: presenter.

	self
		should: [ command execute ]
		raise: PhLCommandError
]
