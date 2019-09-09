"
Pharo Launcher main window presenting the list of managed images as well as a tollbar and a status bar.

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
		basicDescription: 'Images table contextual menu';
		register: PhLLaunchImageCommand2 forSpec;
		register: PhLLaunchImageCommand2 new asSpecLaunchWithoutSettingsCommand;
		register: PhLRenameImageCommand2 forSpec;
		register: PhLDeleteImageCommand2 forSpec;
		register: PhLShowImageInFolderCommand2 forSpec;
		register: PhLCopyPathname2 forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : #commands }
PhLImagesPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		basicDescription: 'Pharo Launcher toolbar';
		register: PhLLaunchImageCommand2 forSpec;
		register: PhLLaunchImageCommand2 new asSpecLaunchWithoutSettingsCommand;
		register: PhLLaunchImageFromDiskCommand forSpec;
		register: PhLImportImageCommand2 forSpec;
		register: PhLShowImageInFolderCommand2 forSpec;
		register: PhLDeleteImageCommand2 forSpec;
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
PhLImagesPresenter >> buildDeleteButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Delete';
		icon: (self iconNamed: #smallDelete);
		help: 'Delete selected image';
		action: [ self deleteSelectedImage ];
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
PhLImagesPresenter >> buildImportButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Import';
		icon: (self iconNamed: #smallLoadProject);
		help: 'Import an external image into Pharo Launcher';
		action: [ self doImport ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildLaunchButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Launch';
		icon: (self iconNamed: #smallDoItIcon);
		help: 'Launch image with settings';
		action: [ self launchSelectedImageWithSettings ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildLaunchWithoutSettingsButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Basic launch';
		icon: (self iconNamed: #smallDoItIcon) asGrayScaleWithAlpha;
		help: 'Launch image without settings';
		action: [ self launchSelectedImageWithoutSettings ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildListContextMenu [

	^ MenuPresenter new 
		addGroup: [ :group | group 
			addItem: [ :item | item name: 'Launch'; action: [ self doLaunch ] ];
			addItem: [ :item | item name: 'Launch without settings'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Edit'; action: [  ] ];
			addItem: [ :item | item name: 'Recreate'; action: [  ] ];
			addItem: [ :item | item name: 'Copy'; action: [  ] ];
			addItem: [ :item | item name: 'Delete'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Show in folder'; action: [  ] ];
			addItem: [ :item | item name: 'Copy path'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Create template'; action: [ ] ] ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildMenuBar [

	^ SpMenuBarPresenter new 
		addGroup: [ :group | group
			addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ];
			addItem: [ :item | item name: 'Help'; subMenu: self buildHelpMenu ] ]
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildNewButtonToolbarItem [

	^ SpToolBarButton new
		label: 'New';
		icon: (self iconNamed: #smallNew);
		help: 'Create an new image';
		action: [ self doNewImage ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildRefreshButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Refresh';
		icon: (self iconNamed: #smallUpdateIcon);
		help: 'Refresh image table';
		action: [ self refresh ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildSettingsButtonToolbarItem [
	^ SpToolBarButton new 
		label: 'Settings';
		icon: (self iconNamed: #smallConfiguration);
		help: 'Allows you to change settings';
		action: [ self doSettings ];
		yourself
]

{ #category : #'private - building' }
PhLImagesPresenter >> buildToolbar [

	^ self newToolBar
		addItem: self buildNewButtonToolbarItem;
		addItem: self buildImportButtonToolbarItem;
		addItem: self buildLaunchButtonToolbarItem;
		addItem: self buildLaunchWithoutSettingsButtonToolbarItem;
		addItem: self buildDeleteButtonToolbarItem;
		addItem: self buildRefreshButtonToolbarItem;
		addItem: self buildSettingsButtonToolbarItem;
		yourself
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
PhLImagesPresenter >> initializePresenter [

	super initializePresenter.
	
	imageTable whenSelectionChangedDo: [ :sel | | selectedImage |
		selectedImage := sel isEmpty
			ifTrue: [ PhLNullImage new ]
			ifFalse: [ sel selectedItem ].
		"launchButton enabled: sel isEmpty not" ].
	"launchButton whenActivatedDo: [ self doLaunch ]"
		
	imageTable transmitTo: descriptionPanel
]

{ #category : #initialization }
PhLImagesPresenter >> initializeWidgets [ 
	imageTable := self newTable
		items: self model images;
		sortingBlock: #lastModification descending;
		contextMenu: self buildListContextMenu;
		doubleClickAction: [ :selected | self doLaunch ];
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 350; yourself);
		addColumn: ((SpStringTableColumn title: 'Architecture' evaluated: #architecture) width: 80; yourself);
		addColumn: ((SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion) width: 80; yourself);
		addColumn: (SpStringTableColumn title: 'Last modified' evaluated: [ :v | self readableDateFor: v lastModification ]);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		yourself.

	descriptionPanel := self instantiate: PhLImageDetailPresenter on: PhLNullImage new.
]

{ #category : #initialization }
PhLImagesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher';
		initialExtent: 700 @ 500;
		toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;
		menu: self buildMenuBar;
		whenBuiltDo: [ :ann | ann model centered ].	
	self rootCommandsGroup installShortcutsIn: aWindowPresenter
]

{ #category : #private }
PhLImagesPresenter >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
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
