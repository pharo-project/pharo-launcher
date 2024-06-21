"
Presenter of a Pharo image detail : description, template, VM, etc.

I'm part of the main Pharo Launcher window.

To open me:
(self on: PhLImage example) openWithSpec
"
Class {
	#name : 'PhLImageDetailPresenter',
	#superclass : 'SpPresenterWithModel',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'description',
		'imageLabel',
		'template',
		'location',
		'vm',
		'templateUrl',
		'updating',
		'actionBar',
		'launchConfigurationList',
		'statusBar',
		'lastEditedLabel',
		'launchConfigurationEdit',
		'initializationScriptEdit',
		'initializationScriptList'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'commands' }
PhLImageDetailPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [

	rootCommandGroup
		register: (self buildToolbarGroupContext: anImagesPresenter)
]

{ #category : 'commands' }
PhLImageDetailPresenter class >> buildToolbarGroupContext: aContext [

	^ (CmCommandGroup named: 'Actions') asSpecGroup
		description: 'Image Launcher actions';
		register: ((CmCommandGroup named: 'Image') asSpecGroup
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
				beDisplayedOnRightSide;
				context: aContext;
				yourself);
			register: (PhLLaunchImageCommand forSpecContext: aContext) beDisplayedOnRightSide;
			register: ((PhLShowImageInFolderCommand forSpecContext: aContext)
				name: 'Show';
				yourself);
			register: (PhLDeleteImageCommand forSpecContext: aContext);
			yourself);
		yourself
]

{ #category : 'specs' }
PhLImageDetailPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
]

{ #category : 'labelled-presenters' }
PhLImageDetailPresenter class >> labelWidth [
	^ 110
]

{ #category : 'initialization' }
PhLImageDetailPresenter >> connectPresenters [

	description whenTextChangedDo: [ :text | self updateImageDescription: text ].
	initializationScriptEdit whenChangedDo: [ :state | self updateImageRunScript: state ]
]

{ #category : 'layout' }
PhLImageDetailPresenter >> defaultLayout [ 
	
	^ SpBoxLayout newTopToBottom 
		borderWidth: 5;
		add: actionBar expand: false;
		add: self descriptionLayout;
		add: statusBar expand: false;
		yourself
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> description [
	^ description
]

{ #category : 'layout' }
PhLImageDetailPresenter >> descriptionLayout [ 

	^ self newPresenter 
		addStyle: 'form';
		"addStyle: 'frame';"
		layout: (SpGridLayout build: [ :builder | builder
			beRowNotHomogeneous;
			beColumnNotHomogeneous;
			borderWidth: 0;
			column: 1 withConstraints: [ :c | c hAlignEnd; vAlignStart ];
			column: 2 withConstraints: [ :c | c beExpand ];
			add: 'Description'; add: description; nextRow;
			add: 'Configuration'; add: (SpBoxLayout newLeftToRight 
					add: launchConfigurationList;
					add: launchConfigurationEdit expand: false;
					yourself); 
				nextRow;
			add: 'Initialization script'; add: (SpBoxLayout newLeftToRight
					add: initializationScriptList "expand: false"; 
					add: initializationScriptEdit expand: false;
					yourself); 
				nextRow;
			add: 'Origin template'; add: template; nextRow;
			add: 'Location'; add: location ]);
		yourself
]

{ #category : 'private - actions' }
PhLImageDetailPresenter >> doEditInitializationScripts [

	^ ((self 
		instantiate: PhLScriptPresenter 
		on: self application scriptsDirectory)
		whenScriptListChanged: [ self updateInitializationScriptList ];
	 	asModalWindow)
			owner: self window;
			withoutButtons;
			open
]

{ #category : 'private - actions' }
PhLImageDetailPresenter >> doEditLaunchConfigurations [
	
	(PhLOpenLaunchConfigurationEditorCommand forContext: self) execute
]

{ #category : 'private - actions' }
PhLImageDetailPresenter >> doShowInFolder [ 

	(PhLShowImageInFolderCommand forContext: self) execute
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> ensurePharoVersion [
	| image |
	
	image := self singleImage.
	[ image ensurePharoVersion ]
	on: PhLImageVersionFileNotFound 
	do: [ :error | 
		| presenter |
		presenter := self instantiate: PhLPharoVersionChooserPresenter.
		presenter openModal.
		presenter version ifNil: [ error pass ].
		image versionFile 
			writeStreamDo: [ :stream | stream nextPutAll: presenter version ] ]
]

{ #category : 'testing' }
PhLImageDetailPresenter >> hasSingleImageSelected [
	
	^ true
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> image [ 
	^ self model
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> imageLabel [
	^ imageLabel
]

{ #category : 'private' }
PhLImageDetailPresenter >> initializationScriptList [
	| files |
	
	files := self application scriptsDirectory files 
		select: [ :file | file extension = 'st' ].	
	files := files copyWith: ((FileSystem memory root / 'No initialization script') ensureCreateFile).
	
	^ files
]

{ #category : 'initialization' }
PhLImageDetailPresenter >> initialize [

	updating := false.
	super initialize
]

{ #category : 'initialization' }
PhLImageDetailPresenter >> initializePresenters [

	imageLabel := self newLabel.
	imageLabel addStyle: 'form_header'.
		
	description := self newText.
	description addScrollBarStyle: 'frame'.

	launchConfigurationList := self newDropList
		items: #();
		display: [ :item | item name ];
		whenSelectedItemChangedDo: [ :aConfiguration | 
			self updateLastSelectedConfiguration: aConfiguration ];
		yourself.	
	launchConfigurationEdit := self newButton 
		addStyle: 'flat';
		icon: (self iconNamed: #edit);
		action: [ self doEditLaunchConfigurations ];
		yourself.

	template := self newLink.
	"templateUrl := self newLabel."
	initializationScriptList := self newDropList
		display: [ :item | item basename ];
		whenSelectedItemChangedDo: [ :aReference | 
			self updateInitializationScript: aReference ];
		yourself.
	initializationScriptEdit := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #edit);
		action: [ self doEditInitializationScripts ];
		yourself.
	
	location := self newLink.
	
	vm := self newTextInput.
	
	actionBar := self newActionBar.
	actionBar addStyle: 'action_bar'.
	actionBar add: ((PhLDeleteImageCommand forSpecContext: self) asActionButtonPresenter
		addStyle: 'flat';
		yourself).
	actionBar add: ((PhLShowImageInFolderCommand forSpecContext: self) asActionButtonPresenter
		addStyle: 'flat';
		yourself).
	actionBar addLast: ((PhLLaunchImageCommand forSpecContext: self) asActionButtonPresenter
		"addStyle: 'circular';"
		yourself).
	actionBar centerPresenter: imageLabel.

	statusBar := self newPresenter.
	statusBar addStyle: 'status_bar'.
	statusBar layout: (SpBoxLayout newHorizontal
		vAlignCenter;
		add: (lastEditedLabel := self newLabel);
		yourself).
		
	lastEditedLabel 
		addStyle: 'greenOnGray';
		addStyle: 'status_message'
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> location [
	^ location
]

{ #category : 'updating' }
PhLImageDetailPresenter >> modelChanged [
	
	updating := true.
	
	self updateImage.
	self refreshLaunchConfigurationList.
	
	updating := false
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> refreshLaunchConfigurationList [
	| image configurations |
	
	[ image := self singleImage ]
	on: PhLCommandError
	do: [ 
		self resetLaunchConfigurationList.
		^ self ].
	
	configurations := image launchConfigurations 
		copyWithFirst: (PhLLaunchConfiguration basicWithImage: image).
	launchConfigurationList
		resetSelection;
		items: configurations.
	
	configurations size > 1 ifTrue: [
		[ launchConfigurationList selectItem: image lastUsedConfiguration ]
			"Default configuration has been deleted but there are still other configurations"
			on: NotFound 
			do: [ launchConfigurationList selectIndex: 2 ] ]
]

{ #category : 'private' }
PhLImageDetailPresenter >> resetLaunchConfigurationList [

	launchConfigurationList
		resetSelection;
		items: #() "no image selected"
]

{ #category : 'api - selection' }
PhLImageDetailPresenter >> selectedImages [
	
	^ { self image }
]

{ #category : 'selection' }
PhLImageDetailPresenter >> selectedLaunchConfiguration [
	
	^ launchConfigurationList selectedItem
]

{ #category : 'private' }
PhLImageDetailPresenter >> singleImage [
	
	^ self model
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> template [
	^ template
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> templateUrl [
	^ templateUrl
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateImage [
	| image |
	
	image := self image ifNil: [ PhLNullImage new ].
	
	imageLabel label: image name.
	lastEditedLabel label: 'Last modified: ', (image lastModification 
		ifNotNil: [ :time | PhLTimeUntilNowStrategy displayStringOf: time ]
		ifNil: [ 'N/A' ] ).
	
	description text: image description.
	
	template 
		label: (image originTemplateName ifEmpty: [ '(noname)' ]);
		url: image originTemplateUrl;
		help: image originTemplateUrl.
	
	initializationScriptList 
		items: self initializationScriptList;
		selectItem: image initializationScript.
	
	location 
		label: image location asFileReference parent fullName;
		action: [ self doShowInFolder ];
		help: image location.
		
	vm text: 'N/A'. "self image vm."
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateImageDescription: text [
	
	updating ifTrue: [ ^ self ].

	PhLImageDescriptionUpdater 
		image: self image 
		description: text
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateImageRunScript: state [

	updating ifTrue: [ ^ self ].
	
	self image shouldRunInitializationScript: state
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateInitializationScript: aReference [

	self image initializationScript: aReference
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateInitializationScriptList [
	
	initializationScriptList items: self initializationScriptList
]

{ #category : 'private - updating' }
PhLImageDetailPresenter >> updateLastSelectedConfiguration: aLaunchConfiguration [

	(aLaunchConfiguration isNil or: [ aLaunchConfiguration isBasicOrDefault ])
		 ifTrue: [ ^ self ].
	self image lastUsedConfiguration: aLaunchConfiguration.
]

{ #category : 'accessing' }
PhLImageDetailPresenter >> vm [
	^ vm
]
