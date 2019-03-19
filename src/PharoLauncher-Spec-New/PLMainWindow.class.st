Class {
	#name : #PLMainWindow,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'runButton',
		'imageTable',
		'descriptionPanel',
		'buttonBar'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLMainWindow class >> defaultSpec [

	^ SpecBoxLayout newVertical
		add: (SpecPanedLayout newVertical
			add: #imageTable;
			add: #descriptionPanel;
			yourself);
		add: #buttonBar expand: false fill: false padding: 0;
		yourself
]

{ #category : #'private building' }
PLMainWindow >> buildFileMenu [

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

{ #category : #'private building' }
PLMainWindow >> buildHelpMenu [
	
	^ MenuPresenter new 
		addGroup: [ :fileGroup | fileGroup
			addItem: [ :subitem | subitem name: 'About...'; action: [  ] ] ];
		yourself
]

{ #category : #'private building' }
PLMainWindow >> buildListContextMenu [

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

{ #category : #'private building' }
PLMainWindow >> buildMenuBar [

	^ MenuBarPresenter new 
		addGroup: [ :group | group
			addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ];
			addItem: [ :item | item name: 'Help'; subMenu: self buildHelpMenu ] ]
]

{ #category : #'private building' }
PLMainWindow >> buildToolbar [

	^ self newToolbarPresenter
		addButtonLabel: 'New'
			iconNamed: #smallNew
			help: 'Create an new image'
			action: [ self doNewImage ];
		addButtonLabel: 'Import' 
			iconNamed: #smallLoadProject 
			help: 'Import an external image into Pharo Launcher' 
			action: [ self doImport ];
		addButtonLabel: 'Settings' 
			iconNamed: #smallConfiguration 
			help: 'Allows you to change settings' 
			action: [ self doSettings ];
		yourself
]

{ #category : #accessing }
PLMainWindow >> descriptionPanel [
	^ descriptionPanel
]

{ #category : #accessing }
PLMainWindow >> descriptionPanel: anObject [
	descriptionPanel := anObject
]

{ #category : #actions }
PLMainWindow >> doImport [

	self window inform: 'TODO'
]

{ #category : #actions }
PLMainWindow >> doLaunch [
	
	imageTable selection selectedItem launch
]

{ #category : #actions }
PLMainWindow >> doNewImage [
	| repository dialog |
	
	repository := PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
	dialog := (PLCreateImageDialog 
		newApplication: self application 
		model: repository) 
		openDialogWithSpec.
	dialog isOk ifFalse: [ ^ self ]. 
	imageTable items: self model images
]

{ #category : #actions }
PLMainWindow >> doSettings [

	(PLSettingsDialog newApplication: self application) openDialogWithSpec
]

{ #category : #accessing }
PLMainWindow >> imageTable [
	
	^ imageTable
]

{ #category : #accessing }
PLMainWindow >> imageTable: anObject [
	imageTable := anObject
]

{ #category : #initialization }
PLMainWindow >> initializePresenter [

	super initializePresenter.
	
	imageTable whenSelectionChangedDo: [ :sel | | selectedImage |
		selectedImage := sel isEmpty
			ifTrue: [ PhLNullImage new ]
			ifFalse: [ sel selectedItem ].
		descriptionPanel model: selectedImage.
		runButton enabled: sel isEmpty not ].
	runButton whenActivatedDo: [ self doLaunch ]
]

{ #category : #initialization }
PLMainWindow >> initializeWidgets [

	imageTable := self newTable
		items: self model images;
		sortingBlock: #lastModification descending;
		contextMenu: self buildListContextMenu;
		doubleClickAction: [ :selected | self doLaunch ];
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		addColumn: (StringTableColumn title: 'Architecture' evaluated: #arch);
		addColumn: (StringTableColumn title: 'Modified' evaluated: [ :v | self readableDateFor: v lastModification ]);
		yourself.

	descriptionPanel := self instantiate: PLImageDescriptionPanel on: PhLNullImage new.
	
	buttonBar := self newButtonBar 
		placeAtEnd;
		add: (runButton := self newButton
			label: 'Launch';
			help: 'Launchs the selected image.';
			enabled: false;
			yourself);
		yourself.
		

]

{ #category : #initialization }
PLMainWindow >> initializeWindow: aWindow [

	aWindow 
		title: 'Pharo Launcher';
		initialExtent: 700@500;
		toolBar: self buildToolbar;
		menu: self buildMenuBar;
		centered
]

{ #category : #private }
PLMainWindow >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
]

{ #category : #accessing }
PLMainWindow >> runButton [
	^ runButton
]

{ #category : #accessing }
PLMainWindow >> runButton: anObject [
	runButton := anObject
]
