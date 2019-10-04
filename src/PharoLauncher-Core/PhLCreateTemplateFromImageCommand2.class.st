"
Create a new local template based on the selected image.
"
Class {
	#name : #PhLCreateTemplateFromImageCommand2,
	#superclass : #PhLImageCommand2,
	#instVars : [
		'newTemplateName',
		'willRemoveImage'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLCreateTemplateFromImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNewIcon;
		shortcutKey: $t meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #converting }
PhLCreateTemplateFromImageCommand2 >> asSpecCommandWithImageRemoval [
	self
		willRemoveImage;
		basicName: 'Create Template and delete image';
		basicDescription: 'Create a Template from the selected Pharo image and delete the image just after template creation'.

	^ super asSpecCommand
		"iconName: #smallDoItIcon;"
		"shortcutKey: $l meta, $b meta ;"
		beDisabledWhenCantBeRun;
		yourself
]

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
	"ensure the template is created before removing the image"
	(willRemoveImage and: [self imagesPresenter templateRepository hasLocalTemplateNamed: name])
		ifTrue: [ PhLDeleteImageCommand2 new
						context: context;
						execute ]
]

{ #category : #initialization }
PhLCreateTemplateFromImageCommand2 >> initialize [
	super initialize.
	willRemoveImage := false.
	self
		name: 'Create Template';
		description: 'Create a Template from the selected Pharo image'
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

{ #category : #configuring }
PhLCreateTemplateFromImageCommand2 >> willRemoveImage [
	willRemoveImage := true.
]
