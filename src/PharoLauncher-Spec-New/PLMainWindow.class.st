Class {
	#name : #PLMainWindow,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'runButton',
		'imageTable',
		'descriptionPanel'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLMainWindow class >> defaultSpec [

	^ SpecBoxLayout newVertical
			add: (SpecPanedLayout newHorizontal
				add: #imageTable;
				add: #descriptionPanel;
				yourself);
			add: #runButton expand: false fill: false padding: 0;
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
 
	^ 1200@800
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

	runButton := self newButton
		label: 'Run';
		help: 'Runs the selected image.';
		enabled: false;
		yourself.
		
	imageTable := self newTable
		items: self model images;
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		addColumn: (StringTableColumn title: 'Architecture' evaluated: #arch);
		addColumn: (StringTableColumn title: 'Modified' evaluated: [:e | self readableDateFor: e lastModification]);
		yourself.
		
	descriptionPanel := self instantiate: PLImageDescriptionPanel on: PhLNullImage new
]

{ #category : #initialization }
PLMainWindow >> initializeWindow: aWindow [
	aWindow title: 'Pharo Launcher'.
	aWindow toolBar: ( ToolBarPresenter new 
		addItem: (ToolBarButton new
			label: 'New';
			icon: (self iconNamed: #smallNew);
			help: 'Create or import an image';
			action: [ "NENEN" ];
			yourself);
		yourself).
	aWindow
		menu:
			(MenuBarPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Pharo Launcher';
								subMenu:
									(MenuPresenter new
										addGroup: [ :fileGroup | 
											fileGroup
												addItem: [ :subitem | 
													subitem
														name: 'Settings...';
														action: [  ] ];
												addItem: [ :subitem | 
													subitem
														name: 'Manage VMs...';
														action: [  ] ];
												addItem: [ :subitem | 
													subitem
														name: 'Quit';
														action: [  ] ] ]) ];
						addItem: [ :item | 
							item
								name: 'Help';
								subMenu: 	(MenuPresenter new
										addGroup: [ :fileGroup | 
											fileGroup
												addItem: [ :subitem | 
													subitem
														name: 'About...';
														action: [  ] ]])]])
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
