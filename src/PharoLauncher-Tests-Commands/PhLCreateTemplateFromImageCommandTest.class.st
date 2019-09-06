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
	presenter := PhLTestImagePresenter new.
]

{ #category : #tests }
PhLCreateTemplateFromImageCommandTest >> testCanCreateATemplateWhenSingleImageSelected [
	| command templates |
	command := PhLCreateTemplateFromImageCommand2 new.
	command context: presenter.
	presenter requestAnswer: 'TestTemplate'.
	
	self assert: presenter templateRepository localTemplates isEmpty.
	command execute.
	
	templates := presenter templateRepository localTemplateNames.
	self 
		assert: templates size 
		equals: 1.	
	self
		assertCollection: templates
		hasSameElements: #('TestTemplate').
]
