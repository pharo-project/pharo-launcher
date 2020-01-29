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
		'imageFilter'
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
		register: PhLLaunchImageCommand forSpec;
		register: PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand;
		register: PhLRenameImageCommand forSpec;
		register: PhLDeleteImageCommand forSpec;
		register: PhLShowImageInFolderCommand forSpec;
		register: PhLCopyPathname forSpec;
		register: PhLInspectCommand forSpec;
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

{ #category : #initialization }
PhLImagesPresenter >> connectPresenters [

	super connectPresenters.
	
	imageTable whenSelectionChangedDo: [ :sel | | selectedImage |
		selectedImage := sel isEmpty
			ifTrue: [ PhLNullImage new ]
			ifFalse: [ sel selectedItem ].
		"launchButton enabled: sel isEmpty not" ].
	"launchButton whenActivatedDo: [ self doLaunch ]"
		
	imageTable transmitTo: descriptionPanel
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
				select: [ :each | regexMatcher search: each name asString ] ].
	imageTable items: images
]

{ #category : #'api - selection' }
PhLImagesPresenter >> hasSingleImageSelected [
	^ imageTable selectedItems size = 1
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> imageRepository [
	^ self model
]

{ #category : #initialization }
PhLImagesPresenter >> initializePresenters [
	imageFilter := self newTextInput
		placeholder: 'Enter image name filter ...';
	whenTextChangedDo: [ :filterString | self filter: filterString ];
		autoAccept: true;
		yourself.
	imageTable := self newTable
		items: self imageRepository images;
		sortingBlock: #lastModification descending;
		whenActivatedDo: [ | cmd |
			cmd := self toolbarGroup commandOrGroupNamed: 'Launch'.
			cmd execute ];
		whenSelectionChangedDo: [ :selection | self refreshLaunchConfigurationList ];
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
		yourself.
	descriptionPanel := self
		instantiate: PhLImageDetailPresenter
		on: PhLNullImage new.
	self imageRepository whenChangedSend: #refresh to: self
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
	do: [ launchConfigurationList items: #() "no image selected". ^ self].
	
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
		dropListItems: items;
		selectItem: image defaultLaunchConfiguration.
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
	^ imageTable selectedItems anyOne
]

{ #category : #'api - selection' }
PhLImagesPresenter >> singleImageName [
	self
		ensure: self hasSingleImageSelected.
	^ imageTable selection selectedItem name
]

{ #category : #'api - accessing' }
PhLImagesPresenter >> templateRepository [
	^ self application templateRepository
]

{ #category : #accessing }
PhLImagesPresenter >> toolbarGroup [
	^ self rootCommandsGroup / 'Toolbar'
]
