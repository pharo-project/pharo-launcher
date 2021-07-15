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
		'rootCommandsGroup'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #commands }
PhLImagesPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildToolbarGroup);
		register: (self buildContextualMenuGroup)
]

{ #category : #commands }
PhLImagesPresenter class >> buildContextualMenuGroup [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		description: 'Images table contextual menu';
		register: ((CmCommandGroup named: 'launch') asSpecGroup
			register: PhLLaunchImageCommand forSpec;
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
						name: 'Launch without settings';
						yourself);
			beDisplayedAsGroup;
			yourself);
		register: ((CmCommandGroup named: 'edition') asSpecGroup
			register: PhLRenameImageCommand forSpec;
			register: PhLCopyImageCommand forSpec;
			register: PhLDeleteImageCommand forSpec;
			beDisplayedAsGroup;
			yourself);
		register: PhLRecreateImageCommand forSpec;
		register: PhLShowImageInFolderCommand forSpec;
		register: PhLCopyPathname forSpec;
		register: PhLCopyLaunchCommand forSpec;
		register: PhLCreateTemplateFromImageCommand forSpec;
		register: PhLCreateTemplateFromImageCommand new asSpecCommandWithImageRemoval;
		register: ((CmCommandGroup named: 'extra') asSpecGroup
			register: PhLInspectCommand forSpec;
			yourself);
		beDisplayedAsGroup;
		yourself
]

{ #category : #commands }
PhLImagesPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher toolbar';
		register: PhLOpenNewImageWindowCommand forSpec;
		register: PhLLaunchImageCommand forSpec;
		register: PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand;
		register: PhLLaunchImageFromDiskCommand forSpec;
		register: PhLImportImageCommand forSpec;
		register: PhLRefreshImageRepositoryCommand forSpec;
		register:
			(PhLShowImageInFolderCommand forSpec
				name: 'Show';
				yourself);
		register: PhLDeleteImageCommand forSpec;
		register:
			(PhLQuitCommand forSpec
				beDisplayedOnRightSide;
				yourself);
		register:
			(PhLAboutCommand forSpec
				beDisplayedOnRightSide;
				yourself);
		register:
			(PhLOpenSettingsCommand forSpec
				name: 'Settings';
				beDisplayedOnRightSide;
				yourself);
		register:
			(PhLOpenVmManagerCommand forSpec
				name: 'VMs';
				beDisplayedOnRightSide;
				yourself);
		beDisplayedAsGroup;
		yourself
]

{ #category : #specs }
PhLImagesPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #imageFilter expand: false;
		add: (SpPanedLayout newVertical
			position: 66 percent;
			add: #imageTable;
			add: #descriptionPanel;
			yourself);
		yourself
]

{ #category : #'api - actions' }
PhLImagesPresenter >> actionFilter [
	^ imageFilter
		takeKeyboardFocus
]

{ #category : #'api - actions' }
PhLImagesPresenter >> actionLaunch [
	| cmd |
	cmd := self toolbarGroup commandOrGroupNamed: 'Launch'.
	cmd execute
]

{ #category : #initialization }
PhLImagesPresenter >> connectPresenters [

	super connectPresenters.
	
	imageTable whenSelectionChangedDo: [ :selection |
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
	^ imageTable selectedItems size = 1 and: [ imageTable selectedItems first isNotNil ]
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> imageRepository [
	^ self model
]

{ #category : #initialization }
PhLImagesPresenter >> initializePresenters [
	imageFilter := self newTextInput
		placeholder: 'Enter image name filter ...';
		whenTextChangedDo: [ :filterString | self filter: filterString asLowercase ];
		yourself.
	imageTable := self newTable
		items: self imageRepository images;
		sortingBlock: #lastModification descending;
		whenActivatedDo: [ self actionLaunch ];
		bindKeyCombination: Character cr asShortcut toAction: [ self actionLaunch ];
		whenBuiltDo: [ :tree | tree widget alternateRowsColor ];
		addColumn:
			((SpStringTableColumn title: 'Name' evaluated: #name)
				width: 350;
				yourself);
		addColumn:
			((SpStringTableColumn title: 'Architecture' evaluated: #architecture)
				width: 80;
				yourself);
		addColumn:
			((SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion)
				width: 80;
				yourself);
		addColumn:
			((SpStringTableColumn
				title: 'Last modified'
				evaluated: [ :image | self readableDateFor: image lastModification ])
				sortFunction: #lastModification descending;
				yourself);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		beMultipleSelection;
		yourself.
	descriptionPanel := self
		instantiate: PhLImageDetailPresenter
		on: PhLNullImage new.
	self imageRepository whenChangedSend: #refresh to: self.
	self whenDisplayDo: 
		[ self imageRepository hasImages
				ifTrue: [ self selectImageAt: 1 ] ].
]

{ #category : #initialization }
PhLImagesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher';
		initialExtent: 700 @ 500;
		toolBar: self toolbarGroup asToolbarPresenter;
		centered;
		whenClosedDo: [ self imageRepository unsubscribe: self ].
	self rootCommandsGroup installShortcutsIn: aWindowPresenter.
	aWindowPresenter toolBar 
		addItemLeft: self newLaunchConfigurationDropList afterIndex: 1.
	aWindowPresenter 
		bindKeyCombination: $f command
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
	do: [ self resetLaunchConfigurationList.
			^ self].
	
	items := image launchConfigurations collect: [ :each | 
			SpDropListItem new
				model: each;
				display: [ :config | config name ];
				icon: (self iconNamed: #configuration);
				yourself ].
	items addFirst: (SpDropListItem new
				model: 'Edit configurations ...';
				action: [ self 
					editLaunchConfigurations;
					refreshLaunchConfigurationList ];
				icon: (self iconNamed: #edit);
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
	launchConfigurationList selectItem: aPhLLaunchConfiguration.
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

{ #category : #updating }
PhLImagesPresenter >> updateToolbarCommandsAvailability [
	self withToolbarDo: [ :toolbar |
		self toolbarGroup allCommands do: #updateEnableStatus ]

]

{ #category : #private }
PhLImagesPresenter >> withToolbarDo: aBlock [
	self withWindowDo: [ :window | aBlock value: window toolBar ]
]
