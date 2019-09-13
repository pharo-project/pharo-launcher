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
		register: (PhLShowImageInFolderCommand2 forSpec 
			basicName: 'Show';
			yourself);
		register: PhLDeleteImageCommand2 forSpec;
		register: (PhLOpenVmManagerCommand2 forSpec
			basicName: 'VMs';
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
