"
A simple UI to show locally available Virtual Machines to launch Pharo images.
"
Class {
	#name : #PhLVMPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'vmTable',
		'rootCommandsGroup'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #commands }
PhLVMPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildToolbarGroup);
		register: (self buildContextualMenuGroup)
]

{ #category : #commands }
PhLVMPresenter class >> buildContextualMenuGroup [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		register: PhLUpdateVmCommand forSpec;
		register: PhLShowVmInFolderCommand forSpec;
		register: PhLDeleteVmCommand forSpec;
		yourself

]

{ #category : #commands }
PhLVMPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher VM Manager toolbar';
		register: PhLUpdateVmCommand forSpec;
		register:
			(PhLShowVmInFolderCommand forSpec
				name: 'Show';
				yourself);
		register: PhLDeleteVmCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : #examples }
PhLVMPresenter class >> example [
	<example>
	(self on: PhLVirtualMachinesDataSource default) open
]

{ #category : #accessing }
PhLVMPresenter >> datasource [
	^ self model
]

{ #category : #layout }
PhLVMPresenter >> defaultLayout [
	^ SpBoxLayout newVertical
		add: vmTable;
		yourself
]

{ #category : #initialization }
PhLVMPresenter >> initializePresenters [
	vmTable := self newTable
		whenActivatedDo: [ PhLShowVmInFolderCommand new
									context: self;
									execute  ];
		addColumn: ((SpImageTableColumn title: '' evaluated: 
			[ :vm | | icon |
			icon := vm isValid
				ifTrue: [ self iconNamed: #testGreen ]
				ifFalse: [ self iconNamed: #testNotRun ].
			icon asMorph
				setBalloonText: vm validityDescription;
				yourself.
			]) 
			width: 20);
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 100; yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Last update' 
			evaluated: #lastUpdateTimeDescription) width: 120; yourself);
		addColumn: (SpStringTableColumn title: 'Download URL' evaluated: #downloadUrl);
		showColumnHeaders;
		alternateRowsColor;
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		beMultipleSelection;
		items: self datasource virtualMachines;
		yourself
]

{ #category : #initialization }
PhLVMPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Locally available Virtual Machines';
		initialExtent: 720 @ 300;
		toolbar:
			(self newLaunchToolbar fillWith: self rootCommandsGroup / 'Toolbar');
		centered.

	self rootCommandsGroup installShortcutsIn: aWindowPresenter.
]

{ #category : #private }
PhLVMPresenter >> readableDateFor: aTimestamp [
	^ aTimestamp asDate yyyymmdd , ' ' , aTimestamp asTime print24

]

{ #category : #refreshing }
PhLVMPresenter >> refresh [ 
	vmTable items: self datasource virtualMachines
]

{ #category : #initialization }
PhLVMPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : #accessing }
PhLVMPresenter >> selectedVms [
	^ vmTable selectedItems
]
