"
I'm the view displayed to create an image from a template.

Implementation points:

To give feedback to the user, we display an icon helping the user to know if he already has an image of the same name or not.
At each keystroke in the image title field we check if we already have an image with this name. If we have, we display a red cross to the user.
"
Class {
	#name : #PhLImageCreationPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'reservedImagesNamesCache',
		'imageName',
		'createButton',
		'initScriptText',
		'initScript',
		'editInitScriptButton',
		'descriptionText',
		'imageNameCheck',
		'isNameValid'
	],
	#classVars : [
		'LAST_SELECTED_INDEX'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #layout }
PhLImageCreationPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: 'Image name:' expand: false;
		add: (SpBoxLayout newHorizontal 
				spacing: 5;
				add: #imageName;
				add: #imageNameCheck expand: false;
				yourself)
			expand: false;
		add: 'Image description:' expand: false;
		add: #descriptionText height: 60;
		add: 'Initialization script:' expand: false;
		add: (SpBoxLayout newHorizontal 
				spacing: 5;
				add: #initScript;
				add: #editInitScriptButton expand: false;
				yourself)
			expand: false;
		add: #initScriptText height: 100;
		addLast: #createButton expand: false;
		yourself
]

{ #category : #example }
PhLImageCreationPresenter class >> example [
	(self 
		newApplication: PharoLauncherApplication new
		model: {PhLRemoteTemplate example}) open
]

{ #category : #accessing }
PhLImageCreationPresenter class >> lastSelectedIndex [
	^ LAST_SELECTED_INDEX
]

{ #category : #accessing }
PhLImageCreationPresenter class >> lastSelectedIndex: aNumber [
	LAST_SELECTED_INDEX := aNumber
]

{ #category : #initialization }
PhLImageCreationPresenter >> checkNewName: name [
	"If the image name is taken we display a red cross. Else we display a validation sign. 
	I am called to validate the image displayed is in the right state. If not, I update it. 
	I use a variable to know the state during the last validation."

	| isValid |
	isValid := (PhLImage isValidName: name) 
						and: [ reservedImagesNamesCache ifNotNil: [ (reservedImagesNamesCache includes: name asLowercase) not ] ].

	"Image already in the right state. We skip."
	isNameValid = isValid ifTrue: [ ^ self ].

	(isNameValid := isValid ) ifTrue: [ self showNameOk ] ifFalse: [ self showNameError ]
]

{ #category : #closing }
PhLImageCreationPresenter >> close [ 

	self withWindowDo: [ :window | window close ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> connectPresenters [
	imageName whenTextChangedDo: [ :name | self checkNewName: name ]
]

{ #category : #action }
PhLImageCreationPresenter >> createImageWithCommand: createCommand [
	
	[ createCommand execute.
		self application newImageCreated.
		self close ] 
	on: PhLNameNotAvailableError 
	do: [ 
		self newInformation 
			message: 'An image with the same name already exists! Please choose a new one.';
			alert ] 
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

{ #category : #private }
PhLImageCreationPresenter >> ifValidTemplate: aBlock [
	"execute the block if the template isValid "

	self template ifNil: [ ^ self ].
	self template isTemplate
		ifTrue: [ aBlock value ]
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
PhLImageCreationPresenter >> initialize [

	super initialize.
	reservedImagesNamesCache := self application imageRepository imageNames collect: #asLowercase
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializePresenters [
	| createCommand |
	
	imageName := self newTextInput.
	imageNameCheck := self newImage.
	initScriptText := self newText
		disable;
		yourself.
	initScript := self newDropList
		items: self initializationScriptItems;
		display: [ :file | file basename ];
		whenSelectionChangedDo: [ :selection |
			selection selectedItem ifNotNil: [ :item |
				self class lastSelectedIndex: selection selectedIndex.
				initScriptText text: item model contents ] ];
		yourself.

	self initializeSelectedItem.
	
	descriptionText := self newText.
	editInitScriptButton := self newButton
		addStyle: 'small';
		action: [ self openScriptPresenter ];
		icon: (self iconNamed: #edit);
		yourself.
	
	createCommand := PhLCreateImageFromTemplateCommand forSpecContext: owner.
	(createButton := createCommand asButtonPresenter)
		action: [ self createImageWithCommand: createCommand ].
	createButton disable
]

{ #category : #initialization }
PhLImageCreationPresenter >> initializeSelectedItem [
	| index |
	index := self class lastSelectedIndex.
	index ifNil: [ ^ self ].
	(index between: 1 and: initScript items size) 
		ifTrue: [ ^ self class lastSelectedIndex: 1 ].
	initScript selectIndex: index
]

{ #category : #testing }
PhLImageCreationPresenter >> isNameValid [
	^ isNameValid
]

{ #category : #initialization }
PhLImageCreationPresenter >> modelChanged [ 

	self template ifNil: [ ^ self ].
	
	self template isTemplate
		ifTrue: [ imageName text: self template suggestedImageName ]
		ifFalse: [ self disable ]
]

{ #category : #initialization }
PhLImageCreationPresenter >> noInitializationScriptItem [
	^ (FileSystem memory root / 'No initialization script') ensureCreateFile
]

{ #category : #accessing }
PhLImageCreationPresenter >> okIcon [
	^ self application iconNamed: #smallOk
]

{ #category : #action }
PhLImageCreationPresenter >> openScriptPresenter [

	^ (PhLScriptPresenter
		   newApplication: self application
		   model: self application scriptsDirectory)
		  whenScriptListChanged: [ self refreshInitializationScriptList ];
		  open;
		  yourself
]

{ #category : #refreshing }
PhLImageCreationPresenter >> refreshInitializationScriptList [
	initScript items: self initializationScriptItems.
]

{ #category : #private }
PhLImageCreationPresenter >> showNameError [

	createButton disable.
	imageNameCheck 
		image: (self application iconNamed: #smallCancel);
		help: 'An image with the same name already exists!'
]

{ #category : #private }
PhLImageCreationPresenter >> showNameOk [

	self ifValidTemplate: [ createButton enable ].
	imageNameCheck 
		image: self okIcon;
		help: 'Image name is valid!'
]

{ #category : #initialization }
PhLImageCreationPresenter >> template [
	"Multiple selection is allowed in templates pane => we get a list of templates"
	
	^ self model
]
