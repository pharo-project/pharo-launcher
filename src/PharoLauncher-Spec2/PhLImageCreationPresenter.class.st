"
I'm the view displayed to create an image from a template.
"
Class {
	#name : #PhLImageCreationPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'imageName',
		'createButton',
		'initScriptText',
		'initScript'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLImageCreationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 5;
		add: ''"New Image:'"
			withConstraints: [ :constraints | constraints height: self labelHeight * 1.5 ];
		add: 'Image name:' expand: false;
		add: #imageName expand: false;
		add: 'Initialization script:' expand: false;
		add: #initScript expand: false;
		add: #initScriptText height: 100;
		add: #createButton expand: false;
		yourself
]

{ #category : #example }
PhLImageCreationPresenter class >> example [
	(self on: {PhLRemoteTemplate example}) openWithSpec
]

{ #category : #closing }
PhLImageCreationPresenter >> close [ 
	self window ifNotNil: [ :window | window close ]
]

{ #category : #accessing }
PhLImageCreationPresenter >> imageName [
	^ imageName text
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializePresenters [
	imageName := self newTextInput
		autoAccept: true;
		yourself.
	initScript := self newText.
	launchConfiguration := self newDropList.
	
	(PhLCreateImageFromTemplateCommand forSpecContext: owner)
	in: [ :createImageCommand |
		createButton := createImageCommand asButtonPresenter.
		createButton action: [ createImageCommand execute. self close ] ].
]

{ #category : #initialization }
PhLImageCreationPresenter >> modelChanged [ 
	self template ifNil: [ ^ self ].
	
	imageName text: self template name.
]

{ #category : #initialization }
PhLImageCreationPresenter >> template [
	"Multiple selection is allowed in templates pane => we get a list of templates"
	
	^ self model isEmptyOrNil 
		ifTrue: [ nil ]
		ifFalse: [ self model first ]
]
