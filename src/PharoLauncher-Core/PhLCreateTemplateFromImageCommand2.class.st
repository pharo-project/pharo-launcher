"
Create a new local template based on the selected image.
"
Class {
	#name : #PhLCreateTemplateFromImageCommand2,
	#superclass : #PhLImageCommand2,
	#instVars : [
		'newTemplateName'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #accessing }
PhLCreateTemplateFromImageCommand2 >> confirmTemplateOverride [
	^ self imagesPresenter newConfirmation
		message: 'Do you want to override exisiting template?';
		confirm
]

{ #category : #executing }
PhLCreateTemplateFromImageCommand2 >> execute [
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self imagesPresenter createLocalTemplateFromSelectionNamed: name.
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand2 >> newTemplateName [
	^ newTemplateName 
		ifNil: [ newTemplateName := self requestNewTemplateName: self imagesPresenter singleImageName ]
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand2 >> requestNewTemplateName: aString [
	| templateRepository |
	templateRepository := self imagesPresenter templateRepository.
	^ self imagesPresenter newRequest
		title: 'Template name?';
		initialAnswer: (templateRepository makeUniqueTemplateName: aString);
		validateAnswer: [ :answer | 
			(templateRepository hasLocalTemplateNamed: answer)
				ifTrue: [ self confirmTemplateOverride ]
				ifFalse: [ true ] ];
		request
]
