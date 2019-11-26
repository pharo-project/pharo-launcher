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
		'initScript',
		'vm',
		'imageArguments',
		'createButton'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLImageCreationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 5;
		add: ''"New Image:'"
			withConstraints: [ :constraints | constraints height: self labelHeight * 1.5 ];
		add:
			(SpBoxLayout newHorizontal
				add: 'Image name:' withConstraints: self labelConstraintsBlock;
				add: #imageName;
				yourself)
			height: self inputTextHeight;
		add: 'Initialization script:' withConstraints: self labelConstraintsBlock;
		add: #initScript height: 100;
		add:
			(SpBoxLayout newHorizontal
				add: 'VM:' withConstraints: self labelConstraintsBlock;
				add: #vm;
				yourself)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				add: 'Image arguments:' withConstraints: self labelConstraintsBlock;
				add: #imageArguments;
				yourself)
			height: self inputTextHeight;
		add: #createButton
			withConstraints: [ :constraints | 
				constraints
					height: self buttonHeight;
					width: 100 ];
		yourself
]

{ #category : #example }
PhLImageCreationPresenter class >> example [
	(self on: PhLRemoteTemplate example) openWithSpec
]

{ #category : #specs }
PhLImageCreationPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
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
	imageArguments := self newTextInput
		autoAccept: true;
		yourself.
	imageName := self newTextInput
		autoAccept: true;
		yourself.
	initScript := self newText.
	vm := self newDropList.
	
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
