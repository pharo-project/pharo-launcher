Class {
	#name : #PhLCreateTemplateFromImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLCreateTemplateFromImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #tests }
PhLCreateTemplateFromImageCommandTest >> testCanCreateATemplateAndRemoveImageWhenSingleImageSelected [
	| command templates |
	command := PhLCreateTemplateFromImageCommand new
		willRemoveImage;
		yourself.
	command context: presenter.
	presenter
		selectImageAt: 1;
		requestAnswer: 'TestTemplate'.

	self assertEmpty: presenter templateRepository localTemplates.
	self assert: (presenter imageRepository hasImageNamed: 'TestImage').
	command execute.

	templates := presenter templateRepository localTemplateNames.
	self assert: templates size equals: 1.
	self assertCollection: templates hasSameElements: #('TestTemplate').
	self deny: (presenter imageRepository hasImageNamed: 'TestImage')
]

{ #category : #tests }
PhLCreateTemplateFromImageCommandTest >> testCanCreateATemplateWhenSingleImageSelected [
	| command templates |
	command := PhLCreateTemplateFromImageCommand new.
	command context: presenter.
	presenter
		selectImageAt: 1;
		requestAnswer: 'TestTemplate'.

	self assertEmpty: presenter templateRepository localTemplates.
	command execute.

	templates := presenter templateRepository localTemplateNames.
	self assert: templates size equals: 1.
	self assertCollection: templates hasSameElements: #('TestTemplate')
]
