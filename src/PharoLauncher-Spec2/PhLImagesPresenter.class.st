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
		'launchButton',
		'buttonBar',
		'descriptionPanel'
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
		beDisplayedAsGroup;
		yourself
]

{ #category : #commands }
PhLImagesPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher toolbar';
		register: PhLNewImageCommand forSpec;
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
		add: (SpPanedLayout newVertical
			add: #imageTable;
			add: #descriptionPanel;
			yourself);
		"add: #buttonBar expand: false fill: false padding: 0;"
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildFileMenu [

	^ MenuPresenter new
		addGroup: [ :group | group
			addItem: [ :item | item name: 'New image'; action: [ self doNewImage ] ];
			addItem: [ :item | item name: 'Import'; action: [ self doImport ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Settings...'; action: [ self doSettings ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Manage VMs...'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Quit'; action: [  ] ] ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildHelpMenu [
	
	^ MenuPresenter new 
		addGroup: [ :fileGroup | fileGroup
			addItem: [ :subitem | subitem name: 'About...'; action: [  ] ] ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildMenuBar [

	^ SpMenuBarPresenter new 
		addGroup: [ :group | group
			addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ];
			addItem: [ :item | item name: 'Help'; subMenu: self buildHelpMenu ] ]
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
PhLImagesPresenter >> ensure: aBoolean [
	aBoolean
		ifFalse: [ PhLCommandError signal ]
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
	imageTable := self newTable
		items: self imageRepository images;
		sortingBlock: #lastModification descending;
		doubleClickAction: [ :selected | | cmd |
				cmd := (self rootCommandsGroup / 'Toolbar') commandOrGroupNamed: 'Launch'.
				cmd execute. ];
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 350; yourself);
		addColumn: ((SpStringTableColumn title: 'Architecture' evaluated: #architecture) width: 80; yourself);
		addColumn: ((SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion) width: 80; yourself);
		addColumn: (SpStringTableColumn title: 'Last modified' evaluated: [ :v | self readableDateFor: v lastModification ]);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		yourself.

	descriptionPanel := self instantiate: PhLImageDetailPresenter on: PhLNullImage new.
	
	self imageRepository whenChangedSend: #refresh to: self.
]

{ #category : #initialization }
PhLImagesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher';
		initialExtent: 700 @ 500;
		toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;
		menu: self buildMenuBar;
		whenBuiltDo: [ :ann | ann model centered ];
		whenClosedDo: [ self imageRepository unsubscribe: self ].
	self rootCommandsGroup installShortcutsIn: aWindowPresenter.
]

{ #category : #private }
PhLImagesPresenter >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
]

{ #category : #accessing }
PhLImagesPresenter >> refresh [ 
	imageTable items: self imageRepository images
]

{ #category : #'api - selection' }
PhLImagesPresenter >> selectedImages [
	^ imageTable selectedItems
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
