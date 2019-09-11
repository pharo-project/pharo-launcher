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
		'dataSource'
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
		register: PhLShowVmInFolderCommand forSpec;
		yourself

]

{ #category : #commands }
PhLVMPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		basicDescription: 'Pharo Launcher VM Manager toolbar';
		register: (PhLShowVmInFolderCommand forSpec 
			basicName: 'Show';
			yourself);
		register: PhLDeleteVmCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : #specs }
PhLVMPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #vmTable;
		yourself
]

{ #category : #examples }
PhLVMPresenter class >> example [
	<example>
	(self on: PhLVirtualMachinesDataSource default) openWithSpec
]

{ #category : #accessing }
PhLVMPresenter >> datasource [
	^ self model
]

{ #category : #initialization }
PhLVMPresenter >> initializeWidgets [
	vmTable := self newTable
		items: self datasource virtualMachines;
		doubleClickAction: [ :selected | 
			PhLShowVmInFolderCommand new
				context: self;
				execute  ];
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 50; yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Last update' 
			evaluated: [ :vm | self readableDateFor: vm lastUpdateTime ]) width: 120; yourself);
		addColumn: (SpStringTableColumn title: 'Download URL' evaluated: #downloadUrl);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		beMultipleSelection;
		yourself.
]

{ #category : #initialization }
PhLVMPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Locally available Virtual Machines';
		initialExtent: 520 @ 300;
		toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;
		whenBuiltDo: [ :ann | ann model centered ].	
	self rootCommandsGroup installShortcutsIn: aWindowPresenter
]

{ #category : #private }
PhLVMPresenter >> readableDateFor: aTimestamp [
	^ aTimestamp asDate yyyymmdd , ' ' , aTimestamp asTime print24

]

{ #category : #accessing }
PhLVMPresenter >> selectedVms [
	^ vmTable selectedItems
]
