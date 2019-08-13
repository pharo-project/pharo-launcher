"
PhLMainWindowPharo Launcher main window presenting the list of managed images as well as a tollbar and a status bar.

To open me:
	(PhLMainWindowPresenter on: PhLDirectoryBasedImageRepository default) openWithSpec
"
Class {
	#name : #PhLMainWindowPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'imageTable',
		'launchButton',
		'buttonBar'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #commands }
PhLMainWindowPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildToolbarGroupWith: anImagesPresenter);
		register: (self buildContextualMenuGroupWith: anImagesPresenter)
]

{ #category : #commands }
PhLMainWindowPresenter class >> buildContextualMenuGroupWith: anImagesPresenter [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		basicDescription: 'Images table contextual menu';
		register: (PhLLaunchImageCommand2 forSpec context: anImagesPresenter);
		register: (PhLLaunchImageCommand2 new asSpecLaunchWithoutSettingsCommand 
			context: anImagesPresenter);
		beDisplayedAsGroup;
		yourself
]

{ #category : #commands }
PhLMainWindowPresenter class >> buildToolbarGroupWith: anImagesPresenter [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		basicDescription: 'Pharo Launcher toolbar';
		register: (PhLLaunchImageCommand2 forSpec context: anImagesPresenter);
		register: (PhLLaunchImageCommand2 new asSpecLaunchWithoutSettingsCommand 
			context: anImagesPresenter);
		beDisplayedAsGroup;
		yourself
]

{ #category : #specs }
PhLMainWindowPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: (SpPanedLayout newVertical
			add: #imageTable;
			"add: #descriptionPanel;"
			yourself);
		"add: #buttonBar expand: false fill: false padding: 0;"
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildDeleteButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Delete';
		icon: (self iconNamed: #smallDelete);
		help: 'Delete selected image';
		action: [ self deleteSelectedImage ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildFileMenu [

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
PhLMainWindowPresenter >> buildHelpMenu [
	
	^ MenuPresenter new 
		addGroup: [ :fileGroup | fileGroup
			addItem: [ :subitem | subitem name: 'About...'; action: [  ] ] ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildImportButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Import';
		icon: (self iconNamed: #smallLoadProject);
		help: 'Import an external image into Pharo Launcher';
		action: [ self doImport ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildLaunchButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Launch';
		icon: (self iconNamed: #smallDoItIcon);
		help: 'Launch image with settings';
		action: [ self launchSelectedImageWithSettings ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildLaunchWithoutSettingsButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Basic launch';
		icon: (self iconNamed: #smallDoItIcon) asGrayScaleWithAlpha;
		help: 'Launch image without settings';
		action: [ self launchSelectedImageWithoutSettings ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildListContextMenu [

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
PhLMainWindowPresenter >> buildMenuBar [

	^ SpMenuBarPresenter new 
		addGroup: [ :group | group
			addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ];
			addItem: [ :item | item name: 'Help'; subMenu: self buildHelpMenu ] ]
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildNewButtonToolbarItem [

	^ SpToolBarButton new
		label: 'New';
		icon: (self iconNamed: #smallNew);
		help: 'Create an new image';
		action: [ self doNewImage ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildRefreshButtonToolbarItem [
	^ SpToolBarButton new
		label: 'Refresh';
		icon: (self iconNamed: #smallUpdateIcon);
		help: 'Refresh image table';
		action: [ self refresh ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildSettingsButtonToolbarItem [
	^ SpToolBarButton new 
		label: 'Settings';
		icon: (self iconNamed: #smallConfiguration);
		help: 'Allows you to change settings';
		action: [ self doSettings ];
		yourself
]

{ #category : #'private - building' }
PhLMainWindowPresenter >> buildToolbar [

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

{ #category : #private }
PhLMainWindowPresenter >> ensure: aBoolean [
	aBoolean
		ifFalse: [ PhLCommandError signal ]
]

{ #category : #'api - selection' }
PhLMainWindowPresenter >> hasSingleImageSelected [
	^ imageTable selectedItems size = 1
]

{ #category : #initialization }
PhLMainWindowPresenter >> initializePresenter [

	super initializePresenter.
	
	imageTable whenSelectionChangedDo: [ :sel | | selectedImage |
		selectedImage := sel isEmpty
			ifTrue: [ PhLNullImage new ]
			ifFalse: [ sel selectedItem ].
		"descriptionPanel model: selectedImage."
		"launchButton enabled: sel isEmpty not" ].
	"launchButton whenActivatedDo: [ self doLaunch ]"
]

{ #category : #initialization }
PhLMainWindowPresenter >> initializeWidgets [ 
	imageTable := self newTable
		items: self model images;
		sortingBlock: #lastModification descending;
		contextMenu: self buildListContextMenu;
		doubleClickAction: [ :selected | self doLaunch ];
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn: (SpStringTableColumn title: 'Architecture' evaluated: #architecture);
		addColumn: (SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion);
		addColumn: (SpStringTableColumn title: 'Last modified' evaluated: [ :v | self readableDateFor: v lastModification ]);
		contextMenu: [ (self rootCommandsGroup / 'Context Menu') beRoot asMenuPresenter ];
		yourself.

	"descriptionPanel := self instantiate: PLImageDescriptionPanel on: PhLNullImage new."
]

{ #category : #initialization }
PhLMainWindowPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Pharo Launcher';
		initialExtent: 700@500;
		toolBar: (self rootCommandsGroup / 'Toolbar')  asToolBarPresenter"self buildToolbar";
		menu: self buildMenuBar;
		whenBuiltDo: [ :ann | ann model centered ].
		
	self rootCommandsGroup installShortcutsIn: aWindowPresenter.
]

{ #category : #private }
PhLMainWindowPresenter >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
]

{ #category : #'api - selection' }
PhLMainWindowPresenter >> singleImage [
	self ensure: self hasSingleImageSelected.
	^ imageTable selectedItems anyOne
]
