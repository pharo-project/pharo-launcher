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
		'initScript',
		'editInitScriptButton'
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
		add: (SpBoxLayout newHorizontal 
			add: #initScript;
			add: #editInitScriptButton expand: false;
			yourself)
			expand: false;
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

{ #category : #configuring }
PhLImageCreationPresenter >> disable [
	createButton disable.	
	imageName text: ''
]

{ #category : #configuring }
PhLImageCreationPresenter >> enable [
	createButton enable.
]

{ #category : #accessing }
PhLImageCreationPresenter >> imageName [
	^ imageName text
]

{ #category : #accessing }
PhLImageCreationPresenter >> initializationScript [
	^ initScript selectedItem
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializationScriptItems [
	^ self initializationScripts copyWithFirst: self noInitializationScriptItem
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializationScripts [
	^ self application scriptsDirectory files 
		select: [ :file | file extension = 'st' ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializePresenters [
	imageName := self newTextInput
		             autoAccept: true;
		             yourself.
	initScriptText := self newText.
	initScript := self newDropList
		              items: self initializationScriptItems;
		              display: [ :file | file basename ];
		              whenSelectionChangedDo: [ :selection | 
			              initScriptText text: selection selectedItem model contents ];
		              yourself.
	editInitScriptButton := self newButton
		                        addStyle: 'small';
		                        action: [ self openScriptPresenter ];
		                        icon: (self iconNamed: #edit);
		                        yourself.
	(PhLCreateImageFromTemplateCommand forSpecContext: owner) 
		in: [ 	:createImageCommand | 
		createButton := createImageCommand asButtonPresenter.
		createButton action: [ 
			createImageCommand execute.
			self close ] ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> modelChanged [ 
	self template ifNil: [ ^ self ].
	self template isTemplate
		ifTrue: [ self enable.
			imageName text: self template suggestedImageName ]
		ifFalse: [ self disable ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> noInitializationScriptItem [
	^ (FileSystem memory root / 'No initialization script') ensureCreateFile
]

{ #category : #action }
PhLImageCreationPresenter >> openScriptPresenter [
	^ (PhLScriptPresenter 
		newApplication: self application 
		model: self application scriptsDirectory )
		whenScriptListChanged: [ self refreshInitializationScriptList ];
		openWithSpec;
		yourself
]

{ #category : #refreshing }
PhLImageCreationPresenter >> refreshInitializationScriptList [
	initScript items: self initializationScriptItems.
]

{ #category : #initialization }
PhLImageCreationPresenter >> template [
	"Multiple selection is allowed in templates pane => we get a list of templates"
	
	^ self model isEmptyOrNil 
		ifTrue: [ nil ]
		ifFalse: [ self model first ]
]
