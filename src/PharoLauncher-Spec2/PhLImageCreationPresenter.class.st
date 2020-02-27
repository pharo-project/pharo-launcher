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
		'editInitScriptButton',
		'descriptionText',
		'imageNameCheck'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLImageCreationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		spacing: 5;
		add: 'Image name:' expand: false;
		add: (SpBoxLayout newHorizontal 
			add: #imageName;
			add: #imageNameCheck expand: false;
			yourself)
			expand: false;
		add: 'Image description:' expand: false;
		add: #descriptionText height: 60;
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
	(self 
		newApplication: PharoLauncherApplication new
		model: {PhLRemoteTemplate example}) openWithSpec
]

{ #category : #closing }
PhLImageCreationPresenter >> close [ 
	self window ifNotNil: [ :window | window close ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> connectPresenters [
	imageName whenTextChangedDo: [ :name | 
		(name isEmpty or: [ self application imageRepository hasImageNamed: name])
			ifTrue: [ self showNameError ]
			ifFalse: [ self showNameOk ] ]
]

{ #category : #accessing }
PhLImageCreationPresenter >> description [
	^ descriptionText text asString
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
	imageNameCheck := self newImage.
	initScriptText := self newText
								disable;
								yourself.
	initScript := self newDropList
		              items: self initializationScriptItems;
		              display: [ :file | file basename ];
		              whenSelectionChangedDo: [ :selection | 
			              initScriptText text: selection selectedItem model contents ];
		              yourself.
	descriptionText := self newText
								autoAccept: true;
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
			[ createImageCommand execute.
			self close. ]
				on: PhLNameNotAvailableError 
				do: [ PhLUIInformation new 
						message: 'An image with the same name already exists! Please choose a new one.';
						alert ] ] ]
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

{ #category : #private }
PhLImageCreationPresenter >> showNameError [
	imageNameCheck 
		image: (self iconNamed: #smallError);
		help: 'An image with the same name already exists!'
]

{ #category : #private }
PhLImageCreationPresenter >> showNameOk [
	imageNameCheck 
		image: (self iconNamed: #smallOk);
		help: 'Image name is valid!'
]

{ #category : #initialization }
PhLImageCreationPresenter >> template [
	"Multiple selection is allowed in templates pane => we get a list of templates"
	
	^ self model isEmptyOrNil 
		ifTrue: [ nil ]
		ifFalse: [ self model first ]
]
