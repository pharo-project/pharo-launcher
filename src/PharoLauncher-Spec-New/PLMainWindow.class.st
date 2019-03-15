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

{ #category : #initialization }
PLMainWindow >> buildFileMenu [

	^ MenuPresenter new
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Settings...'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Manage VMs...'; action: [  ] ] ];
		addGroup: [ :group | group
			addItem: [ :item | item name: 'Quit'; action: [  ] ] ];
		yourself
]

{ #category : #initialization }
PLMainWindow >> buildHelpMenu [
	
	^ MenuPresenter new 
		addGroup: [ :fileGroup | fileGroup
			addItem: [ :subitem | subitem name: 'About...'; action: [  ] ] ];
		yourself
]

{ #category : #initialization }
PLMainWindow >> buildMenuBar [

	^ MenuBarPresenter new 
		addGroup: [ :group | group
			addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ];
			addItem: [ :item | item name: 'Help'; subMenu: self buildHelpMenu ] ]
]

{ #category : #initialization }
PLMainWindow >> buildToolbar [

	^ self newToolbarPresenter
		addButtonLabel: 'New'
			iconNamed: #smallNew
			help: 'Create or import an image'
			action: [ self openNewCreateImageDialog ];
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

{ #category : #accessing }
PLMainWindow >> imageTable [
	
	^ imageTable
]

{ #category : #accessing }
PLMainWindow >> imageTable: anObject [
	imageTable := anObject
]

{ #category : #initialization }
PLMainWindow >> initialExtent [
 
	^ 700@500
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
	runButton whenActivatedDo: [ self runSelectedImage ]
]

{ #category : #initialization }
PLMainWindow >> initializeWidgets [

	imageTable := self newTable
		items: self model images;
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		addColumn: (StringTableColumn title: 'Architecture' evaluated: #arch);
		addColumn: (StringTableColumn 
			title: 'Modified' 
			evaluated: [ :e | self readableDateFor: e lastModification ]);
		yourself.

	descriptionPanel := self instantiate: PLImageDescriptionPanel on: PhLNullImage new.
	
	buttonBar := self newButtonBar 
		placeAtEnd;
		add: (runButton := self newButton
			label: 'Run';
			help: 'Runs the selected image.';
			enabled: false;
			yourself);
		yourself.
		

]

{ #category : #initialization }
PLMainWindow >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow 
		title: 'Pharo Launcher';
		toolBar: self buildToolbar;
		menu: self buildMenuBar
]

{ #category : #navigation }
PLMainWindow >> openNewCreateImageDialog [
	
	| repository |
	repository := PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
	
	(self instantiate: PLCreateImageDialogPresenter on: repository) openDialogWithSpec
]

{ #category : #formating }
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

{ #category : #events }
PLMainWindow >> runSelectedImage [
	
	imageTable selection selectedItem launch
]
