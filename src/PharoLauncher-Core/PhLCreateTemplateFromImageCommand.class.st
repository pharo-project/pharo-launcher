"
Create a new local template based on the selected image.
"
Class {
	#name : #PhLCreateTemplateFromImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'newTemplateName',
		'willRemoveImage'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLCreateTemplateFromImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNewIcon;
		shortcutKey: $t meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #converting }
PhLCreateTemplateFromImageCommand >> asSpecCommandWithImageRemoval [
	self
		willRemoveImage;
		name: 'Create Template and delete image';
		description:
			'Create a Template from the selected Pharo image and delete the image just after template creation'.
	^ super asSpecCommand
		iconName: #smallNewIcon;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand >> confirmTemplateOverride [

	^ self imagesPresenter newConfirmation
		parentWindow: self context window;
		message: 'Do you want to override exisiting template?';
		confirm
]

{ #category : #executing }
PhLCreateTemplateFromImageCommand >> execute [
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self imagesPresenter createLocalTemplateFromSelectionNamed: name.
	"ensure the template is created before removing the image"
	(willRemoveImage and: [self imagesPresenter templateRepository hasLocalTemplateNamed: name])
		ifTrue: [ PhLDeleteImageCommand new
						context: context;
						execute ]
]

{ #category : #initialization }
PhLCreateTemplateFromImageCommand >> initialize [
	super initialize.
	willRemoveImage := false.
	self
		name: 'Create Template';
		description: 'Create a Template from the selected Pharo image'
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand >> newTemplateName [
	^ newTemplateName 
		ifNil: [ newTemplateName := self requestNewTemplateName: self imagesPresenter singleImageName ]
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand >> requestNewTemplateName: aString [
	| templateRepository |
	
	templateRepository := self imagesPresenter templateRepository.
	^ self imagesPresenter newRequest
		parentWindow: self context window;
		title: 'Template name?';
		initialAnswer: (templateRepository makeUniqueTemplateName: aString);
		validateAnswer: [ :answer | 
			(templateRepository hasLocalTemplateNamed: answer)
				ifTrue: [ self confirmTemplateOverride ]
				ifFalse: [ true ] ];
		request
]

{ #category : #configuring }
PhLCreateTemplateFromImageCommand >> willRemoveImage [
	willRemoveImage := true.
]
