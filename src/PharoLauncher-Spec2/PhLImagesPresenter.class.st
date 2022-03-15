"
Pharo Launcher main window presenting the list of managed images as well as a toolbar and a status bar.

To open me:
	(self on: PhLDirectoryBasedImageRepository default) openWithSpec
"
Class {
	#name : #PhLImagesPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'imageTable',
		'descriptionPanel',
		'launchConfigurationList',
		'imageFilter',
		'rootCommandsGroup',
		'toolbar'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #commands }
PhLImagesPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [

	rootCommandGroup
		register: (self buildToolbarGroupContext: anImagesPresenter);
		register: (self buildContextualMenuGroupContext: anImagesPresenter)
]

{ #category : #commands }
PhLImagesPresenter class >> buildContextualMenuGroupContext: aContext [

	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		beDisplayedAsGroup;
		description: 'Images table contextual menu';
		register: ((CmCommandGroup named: 'launch') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLLaunchImageCommand forSpecContext: aContext);
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
				context: aContext;
				name: 'Launch without settings';
				yourself);
			yourself);
		register: ((CmCommandGroup named: 'edition') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLRenameImageCommand forSpecContext: aContext);
			register: (PhLCopyImageCommand forSpecContext: aContext);
			register: (PhLDeleteImageCommand forSpecContext: aContext);
			yourself);
		register: (PhLRecreateImageCommand forSpecContext: aContext);
		register: (PhLShowImageInFolderCommand forSpecContext: aContext);
		register: (PhLCopyPathname forSpecContext: aContext);
		register: (PhLCopyLaunchCommand forSpecContext: aContext);
		register: (PhLCreateTemplateFromImageCommand forSpecContext: aContext);
		register: (PhLCreateTemplateFromImageCommand new asSpecCommandWithImageRemoval
			context: aContext;
			yourself);
		register: ((CmCommandGroup named: 'extra') asSpecGroup
			register: (PhLInspectCommand forSpecContext: aContext);
			yourself);
		yourself
]

{ #category : #commands }
PhLImagesPresenter class >> buildToolbarGroupContext: aContext [

	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher toolbar';
		register: ((CmCommandGroup named: 'Create') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLOpenNewImageWindowCommand forSpecContext: aContext);
			yourself);
		register: ((CmCommandGroup named: 'Image') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLLaunchImageCommand forSpecContext: aContext);
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
				context: aContext;
				yourself);
			register: (PhLLaunchImageFromDiskCommand forSpecContext: aContext);
			register: (PhLImportImageCommand forSpecContext: aContext);
			register: (PhLRefreshImageRepositoryCommand forSpecContext: aContext);
			register: ((PhLShowImageInFolderCommand forSpecContext: aContext)
				name: 'Show';
				yourself);
			register: (PhLDeleteImageCommand forSpecContext: aContext);
			yourself);
		register: ((CmCommandGroup named: 'Settings') asSpecGroup
			register: ((PhLOpenVmManagerCommand forSpecContext: aContext)
				name: 'VMs';
				yourself);
			register: ((PhLOpenSettingsCommand forSpecContext: aContext)
				name: 'Settings';
				yourself);
			register: (PhLAboutCommand forSpecContext: aContext);
			register: (PhLQuitCommand forSpecContext: aContext);
			yourself;
		yourself)
]

{ #category : #'api - actions' }
PhLImagesPresenter >> actionFilter [
	^ imageFilter
		takeKeyboardFocus
]

{ #category : #'api - actions' }
PhLImagesPresenter >> actionLaunch [
	| cmd |

	cmd := PhLLaunchImageCommand forContext: self.
	cmd execute
]

{ #category : #initialization }
PhLImagesPresenter >> buildDescriptionPanel [

	^ self
		instantiate: PhLImageDetailPresenter
		on: PhLNullImage new
]

{ #category : #initialization }
PhLImagesPresenter >> buildImageFilter [
			
	^ self newTextInput
		placeholder: 'Enter image name filter ...';
		whenTextChangedDo: [ :filterString | self filter: filterString asLowercase ];
		yourself
]

{ #category : #initialization }
PhLImagesPresenter >> buildImageTable [

	^ self newTable
		activateOnDoubleClick;
		items: self imageRepository images;
		sortingBlock: #lastModification descending;
		whenActivatedDo: [ self actionLaunch ];
		bindKeyCombination: Character cr asShortcut toAction: [ self actionLaunch ];
		"whenBuiltDo: [ :tree | tree widget alternateRowsColor ];"
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name)
			width: 350;
			beSortable;
			yourself);
		addColumn: ((SpStringTableColumn title: 'Architecture' evaluated: #architecture)
			width: 80;
			beSortable;
			yourself);
		addColumn: ((SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion)
			width: 80;
			beSortable;
			yourself);
		addColumn: ((SpStringTableColumn
			title: 'Last modified'
			evaluated: [ :image | self readableDateFor: image lastModification ])
			sortFunction: #lastModification descending;
			yourself);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		beMultipleSelection;
		yourself
]

{ #category : #initialization }
PhLImagesPresenter >> buildToolbar [
	| toolbarGroup |
	
	toolbarGroup := self toolbarGroup.
	^ self newPresenter
		layout: (SpBoxLayout newLeftToRight
			add: (self newLaunchToolbar fillWith: toolbarGroup / 'Create') expand: false;
			add: (SpBoxLayout newTopToBottom 
				vAlignCenter;
				add: self newLaunchConfigurationDropList expand: false;
				yourself);
			add: (self newLaunchToolbar fillWith: toolbarGroup / 'Image') expand: false;
			add: self newLabel; "to create a space"
			addLast: (self newLaunchToolbar fillWith: toolbarGroup / 'Settings') expand: false;
			yourself);
		yourself
]

{ #category : #initialization }
PhLImagesPresenter >> connectPresenters [

	imageTable transmitDo: [ :image |
		self 
			refreshLaunchConfigurationList;
			updateToolbarCommandsAvailability ].
		
	imageTable 
		transmitTo: descriptionPanel
		transform: [ :images | 		
			images size = 1
				ifTrue: [ images first ]
				ifFalse: [ PhLNullImage new ] ]
]

{ #category : #'api - actions' }
PhLImagesPresenter >> createLocalTemplateFromSelectionNamed: aString [
	^ self templateRepository createLocalTemplateFrom: self singleImage named: aString
]

{ #category : #layout }
PhLImagesPresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: toolbar expand: false;
		add: imageFilter expand: false;
		add: (SpPanedLayout newTopToBottom
			positionOfSlider: 55 percent;
			add: imageTable;
			add: descriptionPanel;
			yourself);
		yourself
]

{ #category : #private }
PhLImagesPresenter >> editLaunchConfigurations [
	^ (PhLOpenLaunchConfigurationEditorCommand forContext: self) execute
]

{ #category : #private }
PhLImagesPresenter >> ensure: aBoolean [
	aBoolean
		ifFalse: [ PhLCommandError signal ]
]

{ #category : #private }
PhLImagesPresenter >> filter: regexMatcher [

	| images |
	images := regexMatcher
		ifNil: [ self imageRepository images ]
		ifNotNil: [ self imageRepository images
				select: [ :each | regexMatcher search: each name asString asLowercase ] ].
	imageTable items: images
]

{ #category : #'api - selection' }
PhLImagesPresenter >> hasSingleImageSelected [
	^ (imageTable selectedItems size = 1) and: [ imageTable selectedItems first notNil ]
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> imageRepository [
	^ self model
]

{ #category : #initialization }
PhLImagesPresenter >> initializePresenters [

	toolbar := self buildToolbar.
	imageFilter := self buildImageFilter.
	imageTable := self buildImageTable.
	descriptionPanel := self buildDescriptionPanel.
	
	self imageRepository whenChangedSend: #refresh to: self
]

{ #category : #initialization }
PhLImagesPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pharo Launcher';
		initialExtent: 900@550;
		centered;
		whenClosedDo: [ self imageRepository unsubscribe: self ].
	self rootCommandsGroup installShortcutsIn: aWindowPresenter.
	aWindowPresenter 
		bindKeyCombination: $f meta
		toAction: [ self actionFilter ]
]

{ #category : #initialization }
PhLImagesPresenter >> newLaunchConfigurationDropList [
	^ launchConfigurationList := SpDropListPresenter new
			items: #();
			yourself
]

{ #category : #private }
PhLImagesPresenter >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
]

{ #category : #updating }
PhLImagesPresenter >> refresh [ 

	imageTable items: self imageRepository images.
	self refreshLaunchConfigurationList
]

{ #category : #updating }
PhLImagesPresenter >> refreshLaunchConfigurationList [
	| image items |
	
	[ image := self singleImage ]
	on: PhLCommandError
	do: [ 
		self resetLaunchConfigurationList.
		^ self ].
	
	items := image launchConfigurations 
		collect: [ :each | 
			SpDropListItem new
				model: each;
				display: [ :config | config name ];
				icon: (self application iconNamed: #configuration);
				yourself ]
		as: OrderedCollection.
	
	items addFirst: (SpDropListItem new
				model: 'Edit configurations ...';
				action: [ 
					self 
						editLaunchConfigurations;
						refreshLaunchConfigurationList ];
				icon: (self application iconNamed: #edit);
				yourself ).
	
	launchConfigurationList
		resetSelection;
		dropListItems: items.
	
	[ launchConfigurationList selectItem: image defaultLaunchConfiguration ]
		on: NotFound "Default configuration has been deleted but there are still other configurations"
		do: [ launchConfigurationList selectIndex: 2 ]
]

{ #category : #updating }
PhLImagesPresenter >> resetLaunchConfigurationList [

	launchConfigurationList
		resetSelection;
		items: #() "no image selected".
]

{ #category : #initialization }
PhLImagesPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : #'api - selection' }
PhLImagesPresenter >> selectConfiguration: aPhLLaunchConfiguration [

	launchConfigurationList selectItem: aPhLLaunchConfiguration
]

{ #category : #'api - selection' }
PhLImagesPresenter >> selectImage: aPhLImage [
	imageTable items 
		detect: [ :image | image name = aPhLImage name ]
		ifFound: [ :item | imageTable selectItem: item ]
]

{ #category : #'api - selection' }
PhLImagesPresenter >> selectImageAt: anIndex [
	imageTable selectIndex: anIndex
]

{ #category : #'api - selection' }
PhLImagesPresenter >> selectedImages [
	^ imageTable selectedItems
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> selectedLaunchConfiguration [
	
	^ launchConfigurationList selectedItem
]

{ #category : #'api - selection' }
PhLImagesPresenter >> singleImage [
	self ensure: self hasSingleImageSelected.
	^ imageTable selection selectedItems first
]

{ #category : #'api - selection' }
PhLImagesPresenter >> singleImageName [
	^ self singleImage name
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> templateRepository [
	^ self application templateRepository
]

{ #category : #accessing }
PhLImagesPresenter >> toolbarGroup [
	^ self rootCommandsGroup / 'Toolbar'
]

{ #category : #initialization }
PhLImagesPresenter >> updatePresenter [

	self imageRepository hasImages 
		ifTrue: [ imageTable selectFirst ]

]

{ #category : #updating }
PhLImagesPresenter >> updateToolbarCommandsAvailability [
	self withToolbarDo: [ :toolbar |
		self toolbarGroup allCommands do: #updateEnableStatus ]

]

{ #category : #private }
PhLImagesPresenter >> withToolbarDo: aBlock [

	self withWindowDo: [ :window | aBlock value: window toolbar ]
]
